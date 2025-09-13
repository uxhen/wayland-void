#!/bin/sh
# =============================================================================== #
# Install Packages:                                                               #
# =============================================================================== #
sudo xbps-install -Sy \
    # Intel Drivers:
    vulkan-loader mesa-vulkan-intel intel-video-accel \
    # SYSTEM:
    base-devel elogind xtools mesa-dri \
    # SHELL:
    alacritty nushell carapace \
    # COMPOSITOR:
    river sandbar gtklock swayidle mako wmenu wlr-randr wvkbd wbg \
    # SCREENSHARING TOOLS:
    grim slurp swappy obs xdg-desktop-portal-wlr \
    # COMMAND LINE TOOLS:
    xdg-user-dirs xdg-utils psmisc man-db opendoas trash-cli htop aria2 ffmpeg ImageMagick ouch \
    yazi fastfetch yt-dlp chafa rsync eza bat glow starship wl-clipboard tealdeer  \
    neovim lazygit fzf fd ripgrep zoxide pastel delta curl jq brightnessctl \
    # Graphical TOOLS:
    mpv imv zathura zathura-pdf-mupdf \
    firefox qutebrowser nemo gimp shotcut \
    # STORAGE TOOLS:
    udiskie simple-mtpfs WoeUSB-cli \
    gvfs gvfs-mtp gvfs-smb gvfs-afc gvfs-gphoto2 \
    # NETWORKING TOOLS:
    NetworkManager network-manager-applet linux-wifi-hotspot \
    net-tools wireless_tools bind-utils iputils inetutils-telnet \
    # WAYLAND QT Tools:
    qt5ct qt6ct qt5-wayland qt6-wayland kvantum  \
    # SOUNDS TOOLS:
    pipewire wireplumber alsa-pipewire alsa-utils pamixer pavucontrol \
    # BLUETOOTHS TOOLS
    bluez bluez-alsa libspa-bluetooth blueman \
    # LANGUAGE TOOLS:
    nodejs lua-language-server  \
    # FONTS:
    noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji noto-fonts-cjk \
    font-awesome dejavu-fonts-ttf \
    # theme
    gtk-engine-murrine breeze-hacked-cursor-theme papirus-icon-theme
