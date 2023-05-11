
# MacPorts Installer addition on 2020-12-10_at_15:27:56: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2020-12-10_at_15:27:56: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles

# make tmux not to source /etc/profile
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi
