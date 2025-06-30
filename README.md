# WBFS Format and Copy Script

## Introduction

Here's a Bash script that recursively scans a folder for .wbfs files, parses the game name and Game ID from the filename (like My Game Title [ABCD01].wbfs), and moves them to the correct wbfs/Game Title [GAMEID]/GAMEID.wbfs structure on your external drive.

## Instructions

'''bash 
chmod +x organize_wbfs.sh
./organize_wbfs.sh ~/WiiGames /media/usbdrive
```
Or Replace $1 and $2 with the folder path