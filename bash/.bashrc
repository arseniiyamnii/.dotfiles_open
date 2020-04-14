export TERM=xterm-256color
xrdb ~/.Xresources
export YOUCANINSTALL=""

if ! [ -z "$PS1" ]; then
	if [ -x "$(command -v tmux)" ]; then
		tmux attach || tmux new -s work
		#tmux new
		#tmux has-session -t work 2>/dev/null
		#if [ $? != 0 ]; then
			#tmux kill-server
			#tmux new -s work
		#fi
	else
		export YOUCANINSTALL="tmux $YOUCANINSTALL"
	fi
	if [ -f ~/.scripts/gitchecker.sh ]; then
		source ~/.scripts/gitchecker.sh
	fi
fi





# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

	# Set name of the theme to load. Optionally, if you set this to "random"
	# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="font"

	# Uncomment the following line to use case-sensitive completion.
	# CASE_SENSITIVE="true"

	# Uncomment the following line to use hyphen-insensitive completion. Case
	# sensitive completion must be off. _ and - will be interchangeable.
	# HYPHEN_INSENSITIVE="true"

	# Uncomment the following line to disable bi-weekly auto-update checks.
	# DISABLE_AUTO_UPDATE="true"

	# Uncomment the following line to change how often to auto-update (in days).
	# export UPDATE_OSH_DAYS=13

	# Uncomment the following line to disable colors in ls.
	# DISABLE_LS_COLORS="true"

	# Uncomment the following line to disable auto-setting terminal title.
	# DISABLE_AUTO_TITLE="true"

	# Uncomment the following line to enable command auto-correction.
	# ENABLE_CORRECTION="true"

	# Uncomment the following line to display red dots whilst waiting for completion.
	# COMPLETION_WAITING_DOTS="true"

	# Uncomment the following line if you want to disable marking untracked files
	# under VCS as dirty. This makes repository status check for large repositories
	# much, much faster.
	# DISABLE_UNTRACKED_FILES_DIRTY="true"

	# Uncomment the following line if you want to change the command execution time
	# stamp shown in the history command output.
	# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
	# HIST_STAMPS="mm/dd/yyyy"

	# Would you like to use another custom folder than $OSH/custom?
	# OSH_CUSTOM=/path/to/new-custom-folder

	# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
	# Custom completions may be added to ~/.oh-my-bash/custom/completions/
	# Example format: completions=(ssh git bundler gem pip pip3)
	# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

	# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
	# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
	# Example format: aliases=(vagrant composer git-avh)
	# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

	# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
	# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
	# Example format: plugins=(rails git textmate ruby lighthouse)
	# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

	# User configuration
	# export MANPATH="/usr/local/man:$MANPATH"

	# You may need to manually set your language environment
	# export LANG=en_US.UTF-8

	# Preferred editor for local and remote sessions
	# if [[ -n $SSH_CONNECTION ]]; then
	#   export EDITOR='vim'
	# else
	#   export EDITOR='mvim'
	# fi

	# Compilation flags
	# export ARCHFLAGS="-arch x86_64"

	# ssh
	# export SSH_KEY_PATH="~/.ssh/rsa_id"

	# Set personal aliases, overriding those provided by oh-my-bash libs,
	# plugins, and themes. Aliases can be placed here, though oh-my-bash
	# users are encouraged to define aliases within the OSH_CUSTOM folder.
	# For a full list of active aliases, run `alias`.
	#
	# Example aliases
	# alias bashconfig="mate ~/.bashrc"
	# alias ohmybash="mate ~/.oh-my-bash"
	# 

fzfignore=''
fzfignore='-not -path "*/\node_modules/*" '$fzfignore
fzfignore='-not -path "*/\.git/*" '$fzfignore
fzfignore='-not -path "*/\.vim/view/*" '$fzfignore
fzfignore='-not -path "*/\.vim/undodir/*" '$fzfignore
fzfignore='-not -path "*/\.cache/*" '$fzfignore
export FZF_DEFAULT_COMMAND='find -L -type f '$fzfignore
if [ -x "$(command -v thefuck)" ]; then
	#	echo 'Error: git is not installed.' >&2
	eval "$(thefuck --alias)"
else
	export YOUCANINSTALL="fuck $YOUCANINSTALL"
	echo "you need installed FUCK"
fi
if [ -x "$(command -v direnv)" ]; then
	eval "$(direnv hook bash)"
else
	export YOUCANINSTALL="direnv $YOUCANINSTALL"
	echo "you need installed direnv"
fi
clear
if [ -x "$(command -v neofetch)" ]; then
	if [ -f ~/.config/neofetch/my_art ]; then
		neofetch --source ~/.config/neofetch/my_art
	else
		neofetch
	fi
else
	export YOUCANINSTALL="neofetch $YOUCANINSTALL"
	echo "you can install neofetch"
fi
if [[ -n $YOUCANINSTALL ]]; then
	echo "you can install $YOUCANINSTALL"
fi

#export FZF_DEFAULT_COMMAND='ag -l --hidden --ignore .git -g ""' #files
#export FZF_DEFAULT_COMMAND='ag -l --hidden --ignore .git -g ""' #files
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g "" | sed -e "s:/[^/]*$::" | uniq' #dirs

#export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --dirs ""' #files
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
source <(kubectl completion bash)

eval "$(glab completion -s bash)"

complete -C /usr/bin/terraform terraform
