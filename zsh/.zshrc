# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# neofetch # CLI system info

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
# ZSH_THEME="powerlevel10k/powerlevel10k"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
plugins=(sudo web-search copypath history git extract macos)

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"

# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# PATH
YANGBIN=$HOME/yangbin
export PATH=${YANGBIN}:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export GPG_TTY=$(tty)

# Aliases
alias v='nvim'
alias ls='eza'
alias ll='eza -al'
alias lt='eza -T'
alias cat='bat'
alias du='dust'
alias sd='sed'
alias grep='rg'
alias fm='ranger' # joshuto
# homebrew
alias bu='brew update && brew upgrade'
alias buc='brew cu -a'
alias bi='brew install'
alias bic='brew install --cask'
alias bs='brew search'
# kitty
alias icat='kitty +kitten icat' # display image in terminal
alias d='kitty +kitten diff'
# ssh
# alias ssh-1080='ssh yang@10.16.12.102'
alias ssh-3090='ssh yang@10.16.11.108'
alias ssh-3090-2='ssh yang@10.16.12.103'
# alias ssh-tesla-k80='ssh yang@10.20.94.184'
# alias ssh-72='ssh yang@10.20.101.189'

# clash
# export http_proxy=127.0.0.1:7890
# export https_proxy=$http_proxy
# export socks_proxy=127.0.0.1:7891

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
