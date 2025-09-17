# =============================================================================== #
# WAYLAND:                                                                        #
# =============================================================================== #
export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QUTE_QT_WRAPPER=PyQt6
export QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export WLR_NO_HARDWARE_CURSORS=1
export MOZ_ENABLE_WAYLAND=1
export XCURSOR_THEME=Breez_Hacked

# =============================================================================== #
# EXPORTS:                                                                        #
# =============================================================================== #
export PROMPT_COMMAND='history -a'
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export PAGER="less"
export EDITOR="nvim"
export VISUAL="nvim"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export BUN_INSTALL_CACHE_DIR="$HOME/.cache/bun/install/cache"
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# =============================================================================== #
# Clean ~:                                                                        #
# =============================================================================== #
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export HISTFILE="$XDG_CACHE_HOME/history"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export IPYTHONDIR="$HOME/.cache/ipython_config"
export JUPYTER_CONFIG_DIR="$HOME/.cache/jupyter_config"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
export XDEB_PKGROOT=${HOME}/.config/xdeb
export KOMOREBI_CONFIG_HOME="$HOME/.config/komorebi"
export BUN_INSTALL_CACHE_DIR="$HOME/.cache/bun/install/cache"
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"
export NI_DEFAULT_AGENT="npm"
export NI_GLOBAL_AGENT="npm"
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# =============================================================================== #
# SHELL OPTIONS:                                                                  #
# =============================================================================== #
set -o vi
shopt -s cdable_vars
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s histappend

# =============================================================================== #
# Autocomplete:                                                                   #
# =============================================================================== #
source <(carapace _carapace)

# =============================================================================== #
# PROMPT:                                                                         #
# =============================================================================== #
eval "$(starship init bash)"

# =============================================================================== #
# ZOXIDE:                                                                         #
# =============================================================================== #
eval "$(zoxide init bash)"

# =============================================================================== #
# ALIASES:                                                                        #
# =============================================================================== #
# Changing "ls" to "eza":                                                         #
# =============================================================================== #
alias ls="eza --long --group --icons=auto --git --sort=name --group-directories-first"
alias ll="eza --long --group --icons=auto --git --sort=name --group-directories-first"
alias lt="eza --long --group --icons=auto --git --only-dirs --tree --level=3 --sort=modified"
# Cd To Zoxide:                                                                   #
# =============================================================================== #
alias cd="z"
alias cdf="zi"
# Fetch (System Info):                                                            #
# =============================================================================== #
alias fetch="fastfetch"
alias neofetch="fastfetch"
## NeoVim To Vim:                                                                 #
# =============================================================================== #
alias v="nvim"
alias vi="nvim"
alias nv="nvim"
alias vn="nvim"
alias vim="nvim"
alias vid="nohup neovide 2>/dev/null 1>&2 &"
alias nvd="nohup neovide 2>/dev/null 1>&2 &"
# Git Command:                                                                    #
# =============================================================================== #
alias g="git"
alias gi="git init"
alias gs="g status -s"
alias ga="g add --all"
alias gcl="g clone --depth=1"
alias gc="g commit -m"
alias gd="g diff"
alias gl="g log --oneline --graph --all -10"
alias gp="g push -uf origin main"
alias lg="lazygit"
# Void Pkg Manager:                                                               #
# =============================================================================== #
alias pu="doas xbps-install -Syu xbps && doas xbps-install -Su"
alias pi="doas xbps-install -S"
alias pr="doas xbps-remove -R"
alias pq="xbps-query -Rs"
alias pl="xbps-query -l"
alias pc="doas xbps-remove -Oo"
alias pclean="doas rm -rf /var/cache/xbps/*"
# For Configs Files:                                                              #
# =============================================================================== #
alias dots="cd ~/.local/wayland-void/"
alias riverc="nvim ~/.config/river/init"
alias swayc="nvim ~/.config/sway/config"
alias wmc="nvim ~/.config/river/init"
alias nuc="nvim ~/.config/nushell/config.nu"
alias bashc="nvim ~/.bashrc"
alias starc="nvim ~/.config/starship.toml"
# Others Usfeual Alias:                                                           #
# =============================================================================== #
alias yt-concats='yt-dlp --ignore-config --downloader aria2c --output "~/Videos/programming/%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --concat-playlist always -S "codec:h264"'
alias yt-music='yt-dlp --ignore-config --config-locations ~/.config/yt-dlp/music'
alias man="tldr"
alias cat="bat"
alias cls="clear"

# =============================================================================== #
# Source fzf keybindingd:                                                         #
# =============================================================================== #
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_COMMAND="fd --type=d --no-hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="
    --prompt='󱓇  ' --layout=reverse
    --preview-window=right,30%
    --style=minimal --height=100% --border --preview-window right,40%
    --color fg:#a6a69c,bg:#181616
    --color bg+:#201d1d,fg+:#c5c9c5
    --color hl:#8a9a7b,hl+:#8a9a7b,gutter:#181616
    --color pointer:#201d1d,info:#393836
    --color border:#181616
    --color border:#8a9a7b
    --bind 'tab:accept'"

# =============================================================================== #
# Tab Completions:                                                                #
# =============================================================================== #
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
bind "set show-all-if-ambiguous off"
bind "set menu-complete-display-prefix on"
bind 'set match-hidden-files off'
bind "set completion-ignore-case on"

# =============================================================================== #
# System Path:                                                                    #
# =============================================================================== #
NPM_PACKAGES="${HOME}/.local/share/npm-packages"
export PATH="$HOME/.config/bin:$HOME/.cargo/bin:$HOME/.local/bin:$NPM_PACKAGES/bin:$PATH"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
