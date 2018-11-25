#!/bin/bash
youtube-dl --add-metadata --metadata-from-title "%(artist)s - %(title)s" --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail \
	--prefer-ffmpeg --youtube-skip-dash-manifest --ignore-errors --restrict-filenames --verbose -o "~/Music/%(title)s.%(ext)s" https://www.youtube.com/playlist?list=PLeNeGOafgoZdslUjEX7vRgtBHHCwl9eY6

