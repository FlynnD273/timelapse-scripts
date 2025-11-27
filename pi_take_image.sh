#!/usr/bin/env dash

name=$(date "+%Y-%m-%d %HC%M.jpg")
rpicam-jpeg -o "/home/flynn/Pictures/Timelapse/$name" --denoise cdn_hq --autofocus-mode manual --lens-position 0
