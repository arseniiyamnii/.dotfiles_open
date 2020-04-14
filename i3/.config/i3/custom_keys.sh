#!/bin/bash
source custom_keys.config
get_curr_workspace () {
  i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2
}
workspace="$(get_curr_workspace)"
#echo $workspace
#echo $w2
if [ $workspace = $w1 ]
then
  i3-msg 'workspace tmux;exec terminator"'
fi
if [ $workspace = $w2 ]
then
  i3-msg 'workspace www;exec firefox'

fi
if [ $workspace = $w3 ]
then
  i3-msg 'workspace chats;exec firefox --new-instance "web.whatsapp.com"'
  i3-msg 'workspace chats;exec discord'
  i3-msg 'workspace chats;exec thunderbird'
  i3-msg 'workspace chats;exec telegram-desktop'
  #telegram
  #discord
fi

