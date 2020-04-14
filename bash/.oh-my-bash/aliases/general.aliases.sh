#!/usr/bin/env bash
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all general BASH aliases
#
#  For your own benefit, we won't load all aliases in the general, we will
#  keep the very generic command here and enough for daily basis tasks.
#
#  If you are looking for the more sexier aliases, we suggest you take a look
#  into other core alias files which installed by default.
#
#  ---------------------------------------------------------------------------

#   -----------------------------
#   1.  MAKE TERMINAL BETTER
#   -----------------------------
alias mtemp = 'echo "$(sensors | grep "temp[0-9]\|Core [0-9]"| awk -F"°C" "{print  $1}" | awk -F"+" "{print $2}" | paste -s -d+ - | bc)/6" | bc'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
#alias ll='ls -lAFh'                         # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias nano='vim'                        # Preferred 'nano' implementation
alias wget='wget -c'                        # Preferred 'wget' implementation (resume download)
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias fix_term='echo -e "\033c"'            # fix_term:     Reset the conosle.  Similar to the reset command
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
alias src='source ~/.bashrc'     # src:          Reload .bashrc file
alias d='du -hs * | sort -h'
alias dr='du -h * | sort -h'
function findt { grep -rl --binary-files=without-match '.' -e "$1"; }
function mkcd { mkdir "$1" && cd "$1"; }
function cd/ { cd /; }
alias cd~='cd ~'
function sshm {
	sudo mkdir -p /mnt/droplet
	sudo sshfs -o cache=no,allow_other,nonempty,default_permissions,IdentityFile=/home/arsenii/.ssh/id_rsa -o reconnect -p ${2:-22} ${1}:/ /mnt/droplet
}
function sshum () { export TEMP_DIR=$(pwd) && cd ~ && sudo umount -f /mnt/droplet && cd $TEMP_DIR; }
if [ -x "$(command -v ranger)" ];then
	alias cdr='. ranger'
	function rcdr {
		sudo mkdir -p /mnt/droplet
		sudo sshfs -o cache=no,allow_other,nonempty,default_permissions,IdentityFile=/home/arsenii/.ssh/id_rsa -o reconnect -p ${2:-22} ${1}:/ /mnt/droplet
		sudo ranger /mnt/droplet
		sudo umount -f /mnt/droplet
	}
else
	export YOUCANINSTALL="ranger $YOUCANINSTALL"
	echo "you need installed ranger"
fi
#alias cdf='cd $(ag --hidden --ignore .git -g "" 2>/dev/null | sed -e "s:/[^/]*$::" | uniq -u | fzf)'
#export FZF_DEFAULT_COMMAND='ag -l --hidden --ignore .git -g ""' #files1
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g "" | sed -e "s:/[^/]*$::" | uniq' #dirs
if [ -x "$(command -v fzf)" ];then
	alias cph='export TEMP_DIR=$(pwd) && cd ~ && cp $(fzf) $TEMP_DIR && cd $TEMP_DIR'
	alias cpf='export TEMP_DIR=$(pwd) && cd ~ && cp $(fzf) $(find -L -type d 2>/dev/null | fzf ) && cd $TEMP_DIR'
	alias cdp='cdf'
	function cdf {
		TEMP_DIR=$(pwd)
		cd ~ 
		DIST_DIR=$(find -L -type d 2>/dev/null | fzf -q "$*" )
		if [ -z "$DIST_DIR" ]; then
			cd $TEMP_DIR
		else 
			cd $DIST_DIR
		fi
	}
	function vip {
		export TEMP_DIR=$(pwd)
		cd $HOME
		filepath=$(find -L -type d 2>/dev/null | fzf -q "$*" --preview 'batcat --color "always" {}')
		if ! [ -z $filepath ];then
		#echo $filepath
		cd $filepath
		vim
		fi
		cd $TEMP_DIR
	}
	function vif {
		export TEMP_DIR=$(pwd)
		cd $HOME
		filepath=$(fzf -q "$*" --preview 'batcat --color "always" {}')
		if ! [ -z $filepath ];then
		#echo $filepath
		vim $filepath
		fi
		cd $TEMP_DIR
	}
	function vipf {
		filepath=$(fzf -q "$*" --preview 'batcat --color "always" {}')
		if ! [ -z $filepath ];then
		#echo $filepath
		vim $filepath
		fi
	}
	function vifp {
		filepath=$(fzf -q "$*" --preview 'batcat --color "always" {}')
		if ! [ -z $filepath ];then
		#echo $filepath
		vim $filepath
		fi
	}
	function scr {
		filepath=$(fzf -q "$*")
		if ! [ -z $filepath ];then
		#echo $filepath
		./${filepath}
		fi
	}
	#alias vif='export TEMP_DIR=$(pwd) && cd ~ && vim $(fzf) && cd $TEMP_DIR' 
else
	export YOUCANINSTALL="fzf $YOUCANINSTALL"
	echo "you need installed fzf"
fi

if [ -x "$(command -v exa)" ]; then
	alias le='exa -lh --grid --sort=ext'
	alias lse='exa -lh --grid --sort=ext -a'
else
	export YOUCANINSTALL="exa $YOUCANINSTALL"
	echo "you can install exa"
fi
function myssh { ssh arsenii@192.168.31.$1; }
