# Awesome Software

List of the awesome software I use(d) for MacOS and Arch Linux.💥

Check [rust repo](https://rustrepo.com/) for a curated list of awesome Rust resources.

<!-- toc -->

- [Package Manager](#package-manager)
- [Terminal](#terminal)
- [CLI Tools](#cli-tools)
  - [zsh plugins](#zsh-plugins)
- [Editors](#editors)
- [Window Manager](#window-manager)
- [Productivity](#productivity)
- [VPN](#vpn)
- [Academic](#academic)
- [Communication](#communication)
- [Email](#email)
- [Cloud Storage](#cloud-storage)
- [Note Taking](#note-taking)
- [Translation](#translation)
- [Other](#other)

<!-- tocstop -->

---

## TL;DR

I mainly use MacOS for now, here is a brief list.

- Package manager: Homebrew
- Terminal: WezTerm
- Shell: zsh (ohmyzsh, powerlevel10k, and plugins)
- CLI tools: joshuto, lazygit, fzf, curl, rg, fd, bat, eza, zoxide, tldr, yt-dlp, delta, yt-dlp, neofetch, slides, loc, gh, onefetch, htop, dust
- Editor: Neovim
- Window Manager: AeroSpace
- Launcher: Raycast
- Academic: Zotero
- Audio/Video: mpv, ffmpeg, vlc, spotify, neteasemusic
- Translation: bob (deepl)
- Cloud Storage: iCloud, OneDrive

---

## Package Manager

Arch Linux

- [yay](https://github.com/Jguer/yay) -- AUR Helper written in Go.
- [paru](https://github.com/Morganamilo/paru) -- AUR helper written in Rust.

MacOS

- [Homebrew](https://brew.sh/) -- Package Manager for MacOS.

---

## Terminal

- [WezTerm](https://github.com/wez/wezterm) -- A GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust.
- [Kitty](https://github.com/kovidgoyal/kitty) -- Fast, feature-rich, GPU based.
- [Alacritty](https://github.com/alacritty/alacritty) -- Sensible defaults, allow configuration, high performance, in Rust.
- [iTerm2](https://www.iterm2.com/) -- A popular terminal emulator. Used for a long time on my MBP.

---

## CLI Tools

- [zsh](https://www.zsh.org/) -- The shell you love.
- [tmux](https://github.com/tmux/tmux) -- Terminal multiplexer.
- [Oh My Zsh](https://ohmyz.sh/) -- Framework for managing Zsh configurations.
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) -- A Zsh theme.
- [curl](https://curl.se/) -- Transferring data with URLs.
- [fzf](https://github.com/junegunn/fzf) -- Fuzzy finder.
- [tldr](https://tldr.sh/) -- Cheatsheets for console commands. (Too Long, Didn't Read)
- [thefuck](https://github.com/nvbn/thefuck) -- Correct errors in previous console command.
- [delta](https://github.com/dandavison/delta) -- A syntax-highlighting pager for git, diff, and grep output.
- [mdBook](https://github.com/rust-lang/mdBook) -- Create modern online books from markdown files. Like Gitbook but implemented in Rust.
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) -- A youtube-dl fork with additional features and fixes.
- [slides](https://maaslalani.com/slides/) -- Terminal slides.
- [loc](https://github.com/cgag/loc) -- Count lines of code.
- [gh](https://cli.github.com/) -- Take GitHub to the CLI.
- [onefetch](https://github.com/o2sh/onefetch) -- Command-line Git information tool.

Some alternatives (many are written in Rust 🦀)

- [fd](https://github.com/sharkdp/fd) -- A simple, fast and user-friendly alternative to `find`.
- [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) -- Fast text searching, faster than `ack`, silver search (`ag`) or `grep`.
- [ripgrep-all](https://github.com/phiresky/ripgrep-all) -- rga: ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, etc.
- [bat](https://github.com/sharkdp/bat) -- A `cat(1)` clone with syntax highlighting and Git integration.
- [eza](https://github.com/eza-community/eza) -- Modern replacement for `ls` since [exa](https://the.exa.website/) is unmaintained.
- [htop](https://github.com/hishamhm/htop) -- Interactive text-mode process viewer for Unix systems, a better `top`.
- [bottom](https://github.com/ClementTsang/bottom) -- A customizable cross-platform graphical process/system monitor for the terminal.
- [dust](https://github.com/bootandy/dust) -- A more intuitive version of `du` in Rust.
- [zoxide](https://github.com/ajeetdsouza/zoxide) -- A smarter `cd` command in Rust, inspired by z and autojump. Or you can try [z.lua](https://github.com/skywind3000/z.lua).
- [procs](https://github.com/dalance/procs) -- A modern replacement for `ps` written in Rust.
- [sd](https://github.com/chmln/sd) -- Intuitive find & replace CLI (`sed` alternative) in Rust.

- Terminal file manager (joshuto requires config for preview, ranger works out of the box)

  [joshuto](https://github.com/kamiyaa/joshuto) -- Ranger-like terminal file manager written in Rust.

  [ranger](https://github.com/ranger/ranger) -- Console file manager with VI key bindings.

  [nnn](https://github.com/jarun/nnn) -- n³ The unorthodox terminal file manager.

- Git UI (lazygit in use)

  [lazygit](https://github.com/jesseduffield/lazygit) -- Simple terminal UI for git commands.

  [gitui](https://github.com/extrawurst/gitui) -- Blazing fast terminal-ui for git written in rust.

- [lazydocker](https://github.com/jesseduffield/lazydocker) -- Simple terminal UI for both docker and docker-compose.

### zsh plugins

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -- A zsh plugin to provide suggestions for the command line.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) -- Syntax highlighting for zsh.

---

## Editors

- [Neovim](https://neovim.io/) -- More of a lifestyle than an editor.
- [Vim](http://www.vim.org/) -- Use when ssh to remote servers.
- [Emacs](https://www.gnu.org/software/emacs/) -- An OS mistaken for an editor, brew coffee with it. xD
- [VSCode](https://code.visualstudio.com/) -- The most popular one.

---

## Window Manager

Arch Linux

- [i3wm](https://i3wm.org/) -- Tiling window manager (X11).
- [Hyprland](https://hyprland.org/) -- Dynamic tiling Wayland compositor.

MacOS

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) -- An i3-like twm for macOS.
- [yabai](https://github.com/koekeishiya/yabai) -- Tiling window manager for MacOS. Use with [skhd](https://github.com/koekeishiya/skhd) for keybindings.

---

## Productivity

Arch

- [Albert](https://albertlauncher.github.io/) -- A fast and flexible keyboard launcher, C++/Qt based.

MacOS

- [Raycast](https://www.raycast.com/) - Raycast is a blazingly fast, totally extendable launcher. It lets you complete tasks, calculate, share common links, and much more.

  Alternative:

  [Alfred](https://www.alfredapp.com/) -- Boosts your efficiency with hotkeys, keywords, text expansion and more.

---

## VPN

- [Clash](https://dreamacro.github.io/clash/) -- Cross-platform rule-based proxy. Use transparent proxy with Clash Premium/ClashX Pro.
- [v2ray](https://www.v2fly.org/) -- A platform for building proxies to bypass network restrictions. [GUI clients](https://www.v2fly.org/awesome/tools.html#%E7%AC%AC%E4%B8%89%E6%96%B9%E5%9B%BE%E5%BD%A2%E5%AE%A2%E6%88%B7%E7%AB%AF).
- [Shadowsocks](https://shadowsocks.org/) -- A fast tunnel proxy that helps you bypass firewalls.

---

## Academic

- [Tex Live](https://www.tug.org/texlive/) -- TeX system. Check [MacTex](https://www.tug.org/mactex/) for MacOS.
- [Zotero](https://www.zotero.org/) -- Collect, organize, annotate, cite, and share research. [Set webdav with Jianguoyun](https://help.jianguoyun.com/?p=3168).

---

## Communication

- [Telegram](https://desktop.telegram.org) -- Messaging app with a focus on speed and security.
- [Discord](https://discordapp.com/) -- All-in-one voice and text chat for gamers that's free, secure.
- [Skype](https://www.skype.com/) -- Cross-platform application that provides video chat and voice call services. Users can exchange images, text, video and any other digital documents.
- [Zoom](https://zoom.us/) -- Online meetings, video conferencing, etc.
- [WeChat](https://itunes.apple.com/app/wechat/id836500024?mt=12) -- Official WeChat app for Mac.

---

## Email

- [Neomutt](https://neomutt.org/) -- Command line mail reader (or MUA). It’s a fork of Mutt with added features.
- [ThunderBird](https://www.mozilla.org/en-US/thunderbird/) -- Email client by Mozilla.

---

## Cloud Storage

- [Dropbox](https://www.dropbox.com/) -- By Dropbox.
- [OneDrive](https://onedrive.live.com) -- By Microsoft. Check [onedrive](https://github.com/abraunegg/onedrive/) for Linux support.
- [Google Drive](https://drive.google.com/) -- By Google. Check [grive2](https://github.com/vitalif/grive2) for Linux support.
- [insync](https://www.insynchq.com/) -- Manage Google Drive, OneDrive, and Dropbox files straight from your Desktop. Cross platform.

---

## Note Taking

org-mode -> markdown

- [Org Mode](https://orgmode.org/) -- Your life in plain text.
- [neorg](https://github.com/nvim-neorg/neorg) -- Your New Life Organization Tool - All in Lua.
- [Obsidian](https://obsidian.md/) -- Sharpen your thinking. Obsidian is the private and flexible note‑taking app that adapts to the way you think.

---

## Translation

- [Bob](https://github.com/ripperhe/Bob) -- Translation & OCR, support many plugins. (MacOS only)
- [pot](https://github.com/pot-app/pot-desktop) -- Cross-platform text translation.

---

## Video/Audio

- [ffmpeg](https://ffmpeg.org/) -- A complete, cross-platform solution to record, convert and stream audio and video.
- [vlc](https://www.videolan.org/) -- Free and open-source, portable, cross-platform media player software and streaming media server.

## Other

MacOS

- [Dash](https://kapeli.com/dash) -- API documentation browser and code snippet manager.
- [CheatSheet](https://www.mediaatelier.com/CheatSheet/) -- Cheatsheet.
- [Amphetamine](https://apps.apple.com/gb/app/amphetamine/id937984704?mt=12) -- Caffeinated, useful when using Macbook with external displays.

---
