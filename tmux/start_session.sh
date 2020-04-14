#!/bin/bash
: ' how to create
tmux new-session -d -s Workspace #create session Workspace
tmux rename-window -t Workspace 'Main' #rename first window
tmux send-keys -t 'Main' 'hellomtrfckr' C-m #send keys to first window
tmux new-window -t Workspace -n 'Second' #create new window(tab)
tmux new-window -t Workspace -n 'Third'
tmux select-window -t 'Second' #go to the second window(tab)
tmux split-window -h #split this window
tmux split-window -v -t 1 #split vertical first pane
tmux split-window -v -t 3 #split vertical second pane
tmux send-keys -t 1 'mc' Enter 
tmux send-keys -t 3 'vim' Enter
tmux attach-session -t Workspace #open session
'
tmux new-session -d -s Workspace #create session Workspace
tmux rename-window -t Workspace 'Main' #rename first window
#tmux new-window -t Workspace -n 'Fun' #create new window(tab)
tmux new-window -t Workspace -n 'WORK' #create new window(tab)

#tmux select-window -t 'Main' #go to the second window(tab)
#tmux split-window -h #split this window
#tmux split-window -v -t 1 #split vertical first pane
#tmux split-window -v -t 3 #split vertical second pane
#tmux send-keys -t 1 'elinks google.com' Enter
#tmux send-keys -t 3 'mc' Enter
#tmux send-keys -t 2 'htop' Enter
#tmux split-window -h -t 2
#tmux send-keys -t 3 'top' Enter

#tmux select-window -t 'Fun' #go to the second window(tab)
#tmux split-window -h #split this window
#tmux split-window -v -t 1 #split vertical first pane
#tmux send-keys -t 1 'weechat' Enter
#tmux send-keys -t 2 'newsbeuter' Enter
#tmux send-keys -t 3 'joplin' Enter
#tmux split-window -v -t 3
#tmux send-keys -t 4 'mutt' Enter

tmux select-window -t 'WORK' #go to the second window(tab)
tmux send-keys -t 'WORK' 'ranger' Enter

tmux attach-session -t Workspace #open session




