#!/bin/bash
sudo apt update
file="$1"
#n=1
while read line; do
# reading each line
sudo apt -y install $line
#n=$((n1)
done < $file
#sudo apt install tmux vlock mc vim-gtk elinks weechat newsbeuter kpcli htop acpi zsh fish mutt rsync davfs2 i3 i3bar i3status rofi neofetch i3blocks
#sudo apt upgrade curl git wget tmux vlock mc vim-gtk elinks weechat newsbeuter kpcli htop acpi zsh fish mutt rsync davfs2
