# Converts a.mkv to a.m4v.
function mkv2mp4() {
  for file in "$@"; do
    ffmpeg -i $file -map 0 -c copy "${file%.*}.m4v"
  done
}

function mkv2mp4_1() {
  for file in "$@"; do
    ffmpeg -i $file -map 0:0 -map 0:1 -c copy -c:s mov_text "${file%.*}.m4v"
  done
}

function mkv2mp4_2() {
  for file in "$@"; do
    ffmpeg -i $file -map 0:0 -map 0:2 -c copy -c:s mov_text "${file%.*}.m4v"
  done
}

function mkv2mp4_3() {
  for file in "$@"; do
    ffmpeg -i $file -map 0:0 -map 0:3 -c copy -c:s mov_text "${file%.*}.m4v"
  done
}

# Adds subs from a.srt to a.m4v.
function addsubs() {
  for file in "$@"; do
    local raw="${file%.*}"
    local old="$raw.m4v"
    local new="$raw-sub.m4v"
    ffmpeg -i $old -i $file -map 0 -map 1 -c copy -c:s mov_text $new
    mv $new $old
    rm $file
  done
}
