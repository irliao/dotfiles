usage() {
cat <<EOF
battery: usage:

  general:
    -h, --help    print this message
    -p            use pmset (more accurate)
    -t            output tmux status bar format
    -a            output ascii bar instead of spark's
    -b            battery path            default: /sys/class/power_supply/BAT0
  colors:
    -g <color>    good battery level      default: green or 1;32
    -m <color>    middle battery level    default: yellow or 1;33
    -w <color>    warn battery level      default: red or 0;31
EOF
}

if [[ $1 == '-h' || $1 == '--help' || $1 == '-?' ]]; then
  usage
  exit 0
fi

# For default behavior
setDefaults() {
  pmset_on=0
  output_tmux=0
  ascii=0
  ascii_bar='=========='
  good_color="1;32"
  middle_color="1;33"
  warn_color="0;31"
  connected=0
  battery_path=/sys/class/power_supply/BAT0
}

setDefaults

battery_charge() {
    case $(uname -s) in
        "Darwin")
            if ((pmset_on)) && hash pmset 2>/dev/null; then
                if [ "$(pmset -g batt | grep -o 'AC Power')" ]; then
                    BATT_CONNECTED=1
                else
                    BATT_CONNECTED=0
                fi
                BATT_PCT=$(pmset -g batt | grep -o '[0-9]*%' | tr -d %)
            else
                while read key value; do
                    case $key in
                        "MaxCapacity")
                            maxcap=$value;;
                        "CurrentCapacity")
                            curcap=$value;;
                        "ExternalConnected")
                            if [ $value == "No" ]; then
                                BATT_CONNECTED=0
                            else
                                BATT_CONNECTED=1
                            fi
                        ;;
                        esac
                    if [[ -n "$maxcap" && -n $curcap ]]; then
                        BATT_PCT=$(( 100 * curcap / maxcap))
                    fi
                done < <(ioreg -n AppleSmartBattery -r | grep -o '"[^"]*" = [^ ]*' | sed -e 's/= //g' -e 's/"//g' | sort)
            fi
            ;;
        "Linux")
			battery_state=$(cat $battery_path/status)
			battery_full=$battery_path/charge_full
			battery_current=$battery_path/charge_now
            if [ $battery_state == 'Discharging' ]; then
                BATT_CONNECTED=0
            else
                BATT_CONNECTED=1
            fi
			now=$(cat $battery_current)
			full=$(cat $battery_full)
			BATT_PCT=$((100 * $now / $full))
            ;;
    esac
}


# Apply the correct color to the battery status prompt
apply_colors() {
# Green
if [[ $BATT_PCT -ge 75 ]]; then
  if ((output_tmux)); then
    COLOR="#[fg=$good_color]"
  else
    COLOR=$good_color
  fi

# Yellow
elif [[ $BATT_PCT -ge 25 ]] && [[ $BATT_PCT -lt 75 ]]; then
  if ((output_tmux)); then
    COLOR="#[fg=$middle_color]"
  else
    COLOR=$middle_color
  fi

# Red
elif [[ $BATT_PCT -lt 25 ]]; then
  if ((output_tmux)); then
    COLOR="#[fg=$warn_color]"
  else
    COLOR=$warn_color
  fi
fi
}

print_status() {
# Print the battery status
    if ((BATT_CONNECTED)); then
        GRAPH="⚡"
    else
        if hash spark 2>/dev/null; then
			sparks=$(spark 0 ${BATT_PCT} 100)
			GRAPH=${sparks:1:1}
        else
            ascii=1
        fi
    fi

    if ((ascii)); then
        barlength=${#ascii_bar}

        # Divides BATTTERY_STATUS by 10 to get a decimal number; i.e 7.6
        n=$(echo "scale = 1; $BATT_PCT / 10" | bc)

        # Round the number to the nearest whole number
        rounded_n=$(printf "%.0f" "$n")

        # Creates the bar
        GRAPH=$(printf "[%-${barlength}s]" "${ascii_bar:0:rounded_n}")
    fi


if ((output_tmux)); then
  # printf "%s%s %s%s" "$COLOR" "[$BATT_PCT%]" "$GRAPH" "#[default]" # original
  printf "%s%s %s%s" "$COLOR" "$BATT_PCT%" "#[default]"
else
  printf "\e[0;%sm%s %s \e[m\n"  "$COLOR" "[$BATT_PCT%]"  "$GRAPH"
fi

}

# Read args
while getopts ":g:m:w:tab:p" opt; do
  case $opt in
    g)
      good_color=$OPTARG
      ;;
    m)
      middle_color=$OPTARG
      ;;
    w)
      warn_color=$OPTARG
      ;;
    t)
      output_tmux=1
      good_color="green"
      middle_color="yellow"
      warn_color="red"
      ;;
    a)
      ascii=1
      ;;
    p)
      pmset_on=1
      ;;
    b)
	  if [ -d $OPTARG ]; then
		battery_path=$OPTARG
	  else
		>&2 echo "Battery not found, trying to use default path..."
	    if [ ! -d $battery_path ]; then
		  >&2 echo "Default battery path is also unreachable"
		  exit 1
		fi
	  fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument"
      exit 1
      ;;
  esac
done

battery_charge
apply_colors
print_status
