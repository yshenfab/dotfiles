# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"
##
# Your previous /Users/yang/.zprofile file was backed up as /Users/yang/.zprofile.macports-saved_2020-11-30_at_06:48:38
##

# MacPorts Installer addition on 2020-11-30_at_06:48:38: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2020-11-30_at_06:48:38: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

eval "$(/usr/local/bin/brew shellenv)"
# Set PATH, MANPATH, etc., for Homebrew.
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
