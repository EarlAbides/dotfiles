# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name''

# ********************************************************************
# *
# *    Start Oh My Zsh template
# *
# ********************************************************************

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export ZSH_CUSTOM=$HOME/.ohmz-custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="apheleia"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:$PATH:/usr/local/bin
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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ********************************************************************
# *
# *    End Oh My Zsh template
# *
# ********************************************************************

# rbenv setup
# export PATH=$HOME/.rbenv/bin:$PATH
# eval "$(rbenv init -)"

# Set golang path
export GOPATH=$HOME/Projects/go
export PATH="$PATH:$GOPATH/bin"

# Add Anaconda path
export PATH="/usr/local/anaconda3/bin:$PATH"

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home

# Source Amazon keys if they exist
if [[ -f $HOME/.awskeys ]]; then
	. $HOME/.awskeys
fi
export AWS_DEFAULT_REGION=us-west-2

# Source aliases if they exist
if [[ -f $HOME/.aliases ]]; then
	. $HOME/.aliases
fi

# Istio config
# export PATH="$PATH:/Users/jearl/Projects/kube/istio-1.0.0/bin"

# Some docker helper functions
# source ~/.docker-functions

# saysomething

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"

# Init direnv
eval "$(direnv hook zsh)"

export SKIP_PROFILE_AND_ALIASES='true'
source ~/git/laptop-setup/config/global/profile

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="/Users/jearl/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#export PATH="/usr/local/opt/maven@3.2/bin:$PATH"
export PHANTOMJS_BIN=/usr/local/bin/phantomjs

export PATH="$HOME/.tgenv/bin:$PATH"

# Source DDC aliases if they exist
if [[ -f $HOME/.ddc_aliases ]]; then
	. $HOME/.ddc_aliases
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jearl/.sdkman"
[[ -s "/Users/jearl/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jearl/.sdkman/bin/sdkman-init.sh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
