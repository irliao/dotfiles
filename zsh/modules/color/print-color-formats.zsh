# original source frpm: https://raw.githubusercontent.com/gabrielelana/dotfiles/master/zsh/plugins/colors/colors.plugin.zsh
show_ansi_colors() {
  text='gYw'

  echo -e "\n                 40m     41m     42m     43m       44m     45m     46m     47m";

  for forground_header in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m'; do
    forground=${forground_header// /}
    echo -en " $forground_header \033[$forground  $text  "
    for background in 40m 41m 42m 43m 44m 45m 46m 47m; do
      echo -en "$EINS \033[$forground\033[$background  $text  \033[0m"
    done
    echo
  done
  echo
}

show_256_colors() {
  index_to_color=(? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?)
  index_to_color[16]='00/00/00'
  index_to_color[17]='00/00/5f'
  index_to_color[18]='00/00/87'
  index_to_color[19]='00/00/af'
  index_to_color[20]='00/00/d7'
  index_to_color[21]='00/00/ff'
  index_to_color[22]='00/5f/00'
  index_to_color[23]='00/5f/5f'
  index_to_color[24]='00/5f/87'
  index_to_color[25]='00/5f/af'
  index_to_color[26]='00/5f/d7'
  index_to_color[27]='00/5f/ff'
  index_to_color[28]='00/87/00'
  index_to_color[29]='00/87/5f'
  index_to_color[30]='00/87/87'
  index_to_color[31]='00/87/af'
  index_to_color[32]='00/87/d7'
  index_to_color[33]='00/87/ff'
  index_to_color[34]='00/af/00'
  index_to_color[35]='00/af/5f'
  index_to_color[36]='00/af/87'
  index_to_color[37]='00/af/af'
  index_to_color[38]='00/af/d7'
  index_to_color[39]='00/af/ff'
  index_to_color[40]='00/d7/00'
  index_to_color[41]='00/d7/5f'
  index_to_color[42]='00/d7/87'
  index_to_color[43]='00/d7/af'
  index_to_color[44]='00/d7/d7'
  index_to_color[45]='00/d7/ff'
  index_to_color[46]='00/ff/00'
  index_to_color[47]='00/ff/5f'
  index_to_color[48]='00/ff/87'
  index_to_color[49]='00/ff/af'
  index_to_color[50]='00/ff/d7'
  index_to_color[51]='00/ff/ff'
  index_to_color[52]='5f/00/00'
  index_to_color[53]='5f/00/5f'
  index_to_color[54]='5f/00/87'
  index_to_color[55]='5f/00/af'
  index_to_color[56]='5f/00/d7'
  index_to_color[57]='5f/00/ff'
  index_to_color[58]='5f/5f/00'
  index_to_color[59]='5f/5f/5f'
  index_to_color[60]='5f/5f/87'
  index_to_color[61]='5f/5f/af'
  index_to_color[62]='5f/5f/d7'
  index_to_color[63]='5f/5f/ff'
  index_to_color[64]='5f/87/00'
  index_to_color[65]='5f/87/5f'
  index_to_color[66]='5f/87/87'
  index_to_color[67]='5f/87/af'
  index_to_color[68]='5f/87/d7'
  index_to_color[69]='5f/87/ff'
  index_to_color[70]='5f/af/00'
  index_to_color[71]='5f/af/5f'
  index_to_color[72]='5f/af/87'
  index_to_color[73]='5f/af/af'
  index_to_color[74]='5f/af/d7'
  index_to_color[75]='5f/af/ff'
  index_to_color[76]='5f/d7/00'
  index_to_color[77]='5f/d7/5f'
  index_to_color[78]='5f/d7/87'
  index_to_color[79]='5f/d7/af'
  index_to_color[80]='5f/d7/d7'
  index_to_color[81]='5f/d7/ff'
  index_to_color[82]='5f/ff/00'
  index_to_color[83]='5f/ff/5f'
  index_to_color[84]='5f/ff/87'
  index_to_color[85]='5f/ff/af'
  index_to_color[86]='5f/ff/d7'
  index_to_color[87]='5f/ff/ff'
  index_to_color[88]='87/00/00'
  index_to_color[89]='87/00/5f'
  index_to_color[90]='87/00/87'
  index_to_color[91]='87/00/af'
  index_to_color[92]='87/00/d7'
  index_to_color[93]='87/00/ff'
  index_to_color[94]='87/5f/00'
  index_to_color[95]='87/5f/5f'
  index_to_color[96]='87/5f/87'
  index_to_color[97]='87/5f/af'
  index_to_color[98]='87/5f/d7'
  index_to_color[99]='87/5f/ff'
  index_to_color[100]='87/87/00'
  index_to_color[101]='87/87/5f'
  index_to_color[102]='87/87/87'
  index_to_color[103]='87/87/af'
  index_to_color[104]='87/87/d7'
  index_to_color[105]='87/87/ff'
  index_to_color[106]='87/af/00'
  index_to_color[107]='87/af/5f'
  index_to_color[108]='87/af/87'
  index_to_color[109]='87/af/af'
  index_to_color[110]='87/af/d7'
  index_to_color[111]='87/af/ff'
  index_to_color[112]='87/d7/00'
  index_to_color[113]='87/d7/5f'
  index_to_color[114]='87/d7/87'
  index_to_color[115]='87/d7/af'
  index_to_color[116]='87/d7/d7'
  index_to_color[117]='87/d7/ff'
  index_to_color[118]='87/ff/00'
  index_to_color[119]='87/ff/5f'
  index_to_color[120]='87/ff/87'
  index_to_color[121]='87/ff/af'
  index_to_color[122]='87/ff/d7'
  index_to_color[123]='87/ff/ff'
  index_to_color[124]='af/00/00'
  index_to_color[125]='af/00/5f'
  index_to_color[126]='af/00/87'
  index_to_color[127]='af/00/af'
  index_to_color[128]='af/00/d7'
  index_to_color[129]='af/00/ff'
  index_to_color[130]='af/5f/00'
  index_to_color[131]='af/5f/5f'
  index_to_color[132]='af/5f/87'
  index_to_color[133]='af/5f/af'
  index_to_color[134]='af/5f/d7'
  index_to_color[135]='af/5f/ff'
  index_to_color[136]='af/87/00'
  index_to_color[137]='af/87/5f'
  index_to_color[138]='af/87/87'
  index_to_color[139]='af/87/af'
  index_to_color[140]='af/87/d7'
  index_to_color[141]='af/87/ff'
  index_to_color[142]='af/af/00'
  index_to_color[143]='af/af/5f'
  index_to_color[144]='af/af/87'
  index_to_color[145]='af/af/af'
  index_to_color[146]='af/af/d7'
  index_to_color[147]='af/af/ff'
  index_to_color[148]='af/d7/00'
  index_to_color[149]='af/d7/5f'
  index_to_color[150]='af/d7/87'
  index_to_color[151]='af/d7/af'
  index_to_color[152]='af/d7/d7'
  index_to_color[153]='af/d7/ff'
  index_to_color[154]='af/ff/00'
  index_to_color[155]='af/ff/5f'
  index_to_color[156]='af/ff/87'
  index_to_color[157]='af/ff/af'
  index_to_color[158]='af/ff/d7'
  index_to_color[159]='af/ff/ff'
  index_to_color[160]='d7/00/00'
  index_to_color[161]='d7/00/5f'
  index_to_color[162]='d7/00/87'
  index_to_color[163]='d7/00/af'
  index_to_color[164]='d7/00/d7'
  index_to_color[165]='d7/00/ff'
  index_to_color[166]='d7/5f/00'
  index_to_color[167]='d7/5f/5f'
  index_to_color[168]='d7/5f/87'
  index_to_color[169]='d7/5f/af'
  index_to_color[170]='d7/5f/d7'
  index_to_color[171]='d7/5f/ff'
  index_to_color[172]='d7/87/00'
  index_to_color[173]='d7/87/5f'
  index_to_color[174]='d7/87/87'
  index_to_color[175]='d7/87/af'
  index_to_color[176]='d7/87/d7'
  index_to_color[177]='d7/87/ff'
  index_to_color[178]='d7/af/00'
  index_to_color[179]='d7/af/5f'
  index_to_color[180]='d7/af/87'
  index_to_color[181]='d7/af/af'
  index_to_color[182]='d7/af/d7'
  index_to_color[183]='d7/af/ff'
  index_to_color[184]='d7/d7/00'
  index_to_color[185]='d7/d7/5f'
  index_to_color[186]='d7/d7/87'
  index_to_color[187]='d7/d7/af'
  index_to_color[188]='d7/d7/d7'
  index_to_color[189]='d7/d7/ff'
  index_to_color[190]='d7/ff/00'
  index_to_color[191]='d7/ff/5f'
  index_to_color[192]='d7/ff/87'
  index_to_color[193]='d7/ff/af'
  index_to_color[194]='d7/ff/d7'
  index_to_color[195]='d7/ff/ff'
  index_to_color[196]='ff/00/00'
  index_to_color[197]='ff/00/5f'
  index_to_color[198]='ff/00/87'
  index_to_color[199]='ff/00/af'
  index_to_color[200]='ff/00/d7'
  index_to_color[201]='ff/00/ff'
  index_to_color[202]='ff/5f/00'
  index_to_color[203]='ff/5f/5f'
  index_to_color[204]='ff/5f/87'
  index_to_color[205]='ff/5f/af'
  index_to_color[206]='ff/5f/d7'
  index_to_color[207]='ff/5f/ff'
  index_to_color[208]='ff/87/00'
  index_to_color[209]='ff/87/5f'
  index_to_color[210]='ff/87/87'
  index_to_color[211]='ff/87/af'
  index_to_color[212]='ff/87/d7'
  index_to_color[213]='ff/87/ff'
  index_to_color[214]='ff/af/00'
  index_to_color[215]='ff/af/5f'
  index_to_color[216]='ff/af/87'
  index_to_color[217]='ff/af/af'
  index_to_color[218]='ff/af/d7'
  index_to_color[219]='ff/af/ff'
  index_to_color[220]='ff/d7/00'
  index_to_color[221]='ff/d7/5f'
  index_to_color[222]='ff/d7/87'
  index_to_color[223]='ff/d7/af'
  index_to_color[224]='ff/d7/d7'
  index_to_color[225]='ff/d7/ff'
  index_to_color[226]='ff/ff/00'
  index_to_color[227]='ff/ff/5f'
  index_to_color[228]='ff/ff/87'
  index_to_color[229]='ff/ff/af'
  index_to_color[230]='ff/ff/d7'
  index_to_color[231]='ff/ff/ff'
  index_to_color[232]='08/08/08'
  index_to_color[233]='12/12/12'
  index_to_color[234]='1c/1c/1c'
  index_to_color[235]='26/26/26'
  index_to_color[236]='30/30/30'
  index_to_color[237]='3a/3a/3a'
  index_to_color[238]='44/44/44'
  index_to_color[239]='4e/4e/4e'
  index_to_color[240]='58/58/58'
  index_to_color[241]='62/62/62'
  index_to_color[242]='6c/6c/6c'
  index_to_color[243]='76/76/76'
  index_to_color[244]='80/80/80'
  index_to_color[245]='8a/8a/8a'
  index_to_color[246]='94/94/94'
  index_to_color[247]='9e/9e/9e'
  index_to_color[248]='a8/a8/a8'
  index_to_color[249]='b2/b2/b2'
  index_to_color[250]='bc/bc/bc'
  index_to_color[251]='c6/c6/c6'
  index_to_color[252]='d0/d0/d0'
  index_to_color[253]='da/da/da'
  index_to_color[254]='e4/e4/e4'
  index_to_color[255]='ee/ee/ee'


  # ANSI colors
  printf '\n'
  for (( h = 0; h < 2; h++ )) do
    for (( c = 0; c < 8; c++ )) do
      (( col = h*8 + c ))
      printf '\e[48;5;%dm %03d \e[m' $col $col
    done
    printf '\n'
  done
 
  # RGB colors
  printf '\n'
  for (( g = 0; g < 6; g++ )) do
    for (( r = 0; r < 6; r++ )) do
      for (( b = 0; b < 6; b++ )) do
        (( col = 16 + r*36 + g*6 + b ))
        printf '\e[48;5;%dm %03d %s \e[m' $col $col $index_to_color[$col]
        if [ $(( $b % 2 )) -eq 1 ]; then
          printf '\n'
        else
          printf ' '
        fi
      done
    done
    printf '\n'
  done
 
  # Grayscale colors
  printf '\n'
  for (( y = 0; y < 3; y++ )) do
    for (( x = 0; x < 8; x++ )) do
      (( col = 232 + y*8 + x ))
      printf '\e[48;5;%dm %03d %s \e[m' $col $col $index_to_color[$col]
      if [ $(( $x % 2 )) -eq 1 ]; then
        printf '\n'
      else
        printf ' '
      fi
    done
    printf '\n'
  done
}