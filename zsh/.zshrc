# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# fortune # random epigram
neofetch # CLI system info

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Plugins
plugins=(git autojump extract web-search archlinux sudo zsh-autosuggestions
  zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export LC_ALL=C
export S_TIME_FORMAT=ISO

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

YANGBIN=$HOME/yangbin
export PATH=${YANGBIN}:$PATH

# Aliases
alias ls='exa'
alias ll='ls -al'
alias lsd='ls -d *(-/DN)'
alias cat='bat'
alias du='du -sh'
alias fn='find . -name'
alias cls='printf "\033c"'
# alias man='tldr'
alias yeet='paru -Rcs'

# kitty
alias icat='kitty +kitten icat' # display image in terminal
alias d='kitty +kitten diff'

# Proxy
# clash
export http_proxy=127.0.0.1:7890
export https_proxy=$http_proxy
export socks_proxy=127.0.0.1:7891

# v2ray
# export http_proxy=127.0.0.1:20171
# export https_proxy=$http_proxy
# export socks_proxy=127.0.0.1:20170

# Golang
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
# export GOPROXY=https://mirrors.aliyun.com/goproxy/

# Stage
export STG=$HOME/stg
export LD_LIBRARY_PATH=$STG/lib
export PATH=$STG/bin:$PATH

# Miniconda
source /opt/miniconda/etc/profile.d/conda.sh

# ROS2 Humble
export ROS_DOMAIN_ID=42
# source /opt/ros/humble/setup.zsh

ros2_on(){
     export ROS_DOMAIN_ID=42
     export ROS_VERSION=2
     export ROS_PYTHON_VERSION=3
     export ROS_DISTRO=humble
     source /opt/ros2/humble/setup.zsh
}

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
