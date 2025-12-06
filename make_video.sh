#!/data/data/com.termux/files/usr/bin/bash

path="$1"
TMP=$(mktemp -d)
mv "$path"/*.jpg "$path"/tmp/
cp "$path"/tmp/*.jpg "$TMP"

vid_name=$(basename "$(find "$TMP" -type f | head -n1)")
vid_name="$path/videos/${vid_name% *}.mp4"

count=1
for file in "$TMP"/*.jpg; do
	overlay=$(basename "$file")
	overlay="${overlay%*.jpg}"
	overlay="${overlay/C/\\:}"
	ffmpeg -i "$file" -vf "transpose=2,scale=1280:-1,crop=1280:720:0:(ih-720),drawtext=text='$overlay':fontcolor=white:fontsize=24:x=(w-text_w)/2:y=h-text_h-10" "$TMP/$count.png" -y
	count=$((count + 1))
done

ffmpeg -framerate 12 -i "$TMP/%d.png" "$vid_name" -y || exit
rm -rf "$TMP"
rm "$path"/tmp/*.jpg
