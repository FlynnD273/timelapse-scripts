#!/usr/bin/env bash

TMP=~/Pictures/tmp
if [[ ! -d "$TMP" ]]; then
mkdir ~/Pictures/tmp
fi
mv ~/Pictures/Timelapse/tmp/*.jpg $TMP

vid_name=$(basename "$(find "$TMP" -type f | head -n1)")
vid_name=~/"Pictures/Timelapse Videos/${vid_name% *}.mp4"

count=1
for file in "$TMP"/*.jpg; do
	overlay=$(basename "$file")
	overlay="${overlay%*.jpg}"
	overlay="${overlay/C/\\:}"
	ffmpeg -i "$file" -vf "unsharp=13:13:5,scale=1280:-1,crop=1280:720:0:(ih-720),drawtext=text='$overlay':fontcolor=white:fontsize=24:x=(w-text_w)/2:y=h-text_h-10" "$TMP/$count.png" -y
	count=$((count + 1))
done

ffmpeg -i "$TMP/%d.png" -vf fps=fps=12 "$vid_name" -y
rm -rf "$TMP"
