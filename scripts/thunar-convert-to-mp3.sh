# #!/bin/sh

# ffmpeg, official documentation: https://ffmpeg.org/documentation.html
# credit to user anon93652015 for original scripts https://forum.endeavouros.com/t/useful-and-use-less-scripts/61327

# ffmpeg options:
# -i, url/input (in this case, infile or selected file)
# -vn, (input) blocks video streams from being used for output - allows faster processing
# -q:a, sets output audio quality to VBR (variable bitrate)
# -q:a 0, sets the output to the highest bitrate possible

for file in "$@"; do
    ffmpeg -i "$file" -vn -acodec libmp3lame -q:a 0 "${file%.*}.mp3"
done

# simplest ffmpeg command for basic video to mp3 format is:
# ffmpeg -i "$file" -vn "${file%.*}.mp3"

# IMPORTANT! CREATE A CUSTOM THUNAR ACTION - https://docs.xfce.org/xfce/thunar/custom-actions
# In a Thunar window > Edit > Configure custom action > Add custom action (+)
# Adjust executable path and set Appearance Conditions to include audio/video files
# 
# [Thunar Action]
# Name=Convert to MP3
# Comment=Convert video file to MP3
# Exec=/path/to/script/convert-to-mp3.sh %F