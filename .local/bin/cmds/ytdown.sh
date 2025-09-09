#!/bin/sh

# Prompt the user to enter the URL of the file
read -p "Enter the URL of the file: " url

# Define an array of download options
options=(
  "MP4 (1080p)"
  "MP4 (720p)"
  "MP4 (480p)"
  "MP4 (360p)"
  "MP3 (128 kbps)"
  "MP3 (256 kbps)"
)

# Prompt the user to select a download option
echo "Select a download option:"
select option in "${options[@]}"; do
  case $option in
    "MP4 (1080p)") format="bestvideo[height<=1080]+bestaudio/best[height<=1080]" && extension=".mp4"; break ;;
    "MP4 (720p)") format="bestvideo[height<=720]+bestaudio/best[height<=720]" && extension=".mp4"; break ;;
    "MP4 (480p)") format="bestvideo[height<=480]+bestaudio/best[height<=480]" && extension=".mp4"; break ;;
    "MP4 (360p)") format="bestvideo[height<=360]+bestaudio/best[height<=360]" && extension=".mp4"; break ;;
    "MP3 (128 kbps)") format="bestaudio/best[abr<=128]" && extension=".mp3"; break ;;
    "MP3 (256 kbps)") format="bestaudio/best[abr<=256]" && extension=".mp3"; break ;;
    *) echo "Invalid option" ;;
  esac
done

# Prompt the user to enter a filename for the downloaded file
read -p "Enter a filename for the downloaded file: " filename

# Download the file
yt-dlp --format "$format" --output "$filename$extension" "$url"

