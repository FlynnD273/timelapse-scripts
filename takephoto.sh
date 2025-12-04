#!/data/data/com.termux/files/usr/bin/bash

cd /data/data/com.termux/files/home || exit
file="storage/pictures/img.jpg"
output="storage/pictures/Timelapse/$(date '+%F %HC%M').jpg"
termux-camera-photo "$file"
size=$(wc -c <"$file")
if [ "$size" -le 3000000 ]; then
	termux-camera-photo "$file"
fi

mv "$file" "$output"
