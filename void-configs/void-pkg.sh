#!/bin/sh
# =============================================================================== #
# Install Packages:                                                               #
# =============================================================================== #
sudo xbps-install -Sy \
    # DRIVERS:
    vulkan-loader mesa-vulkan-intel intel-video-accel \
    # SYSTEM:
    base-devel elogind xtools mesa-dri \
    # SHELL:
    alacritty nushell carapace \
    # COMPOSITOR:
    sway swaylock swayidle mako wmenu wvkbd \
    # SCREENSHARING:
    grim slurp swappy obs xdg-desktop-portal-wlr \
    # CLI
    xdg-user-dirs xdg-utils psmisc man-db opendoas trash-cli htop aria2 ffmpeg ImageMagick ouch \
    yazi fastfetch yt-dlp chafa rsync eza bat glow starship wl-clipboard tealdeer  \
    neovim lazygit fzf fd ripgrep zoxide pastel delta curl jq brightnessctl \
    # GUI
    mpv imv zathura zathura-pdf-mupdf \
    chromium qutebrowser nemo gimp shotcut \
    # DISKS:
    udiskie simple-mtpfs WoeUSB-cli \
    gvfs gvfs-mtp gvfs-smb gvfs-afc gvfs-gphoto2 \
    # NETWORK:
    NetworkManager network-manager-applet linux-wifi-hotspot \
    net-tools wireless_tools bind-utils iputils inetutils-telnet \
    # QT:
    qt5ct qt6ct qt5-wayland qt6-wayland kvantum \
    # SOUND:
    pipewire wireplumber alsa-pipewire alsa-utils pamixer pavucontrol \
    # BLUETOOTH:
    bluez bluez-alsa libspa-bluetooth blueman \
    # PROGRAMMING:
    python3 python3-adblock nodejs lua-language-server \
    # FONTS:
    noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji noto-fonts-cjk \
    font-awesome dejavu-fonts-ttf \
    # THEMES
    gtk-engine-murrine breeze-hacked-cursor-theme papirus-icon-theme
