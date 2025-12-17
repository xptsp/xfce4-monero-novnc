FROM theholm/xfce4-desktop-over-http:latest

# Download supporting packages for Monero GUI Wallet:
RUN apt update && \
    apt install -y libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xkb1 libxkbcommon-x11-0 bzip2 nano curl && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/apt/lists/*

# Download Monero GUI Wallet:
RUN curl https://downloads.getmonero.org/gui/monero-gui-linux-x64-v0.18.4.4.tar.bz2 -o linux64 && \
    tar xfv linux64 && \
    rm linux64 && \
    mv monero-gui-v0.18.4.4 /usr/local/monero-gui

# Copy Monero GUI desktop file to several directories:
COPY files/monero-gui.desktop /usr/share/applications/monero-gui.desktop
RUN chmod +x /usr/share/applications/monero-gui.desktop && \
    ln -sf /usr/share/applications/monero-gui.desktop /etc/xdg/autostart/monero-gui.desktop && \
    mkdir -p /home/user/Desktop && \
    cp /usr/share/applications/monero-gui.desktop /home/user/Desktop/ && \
    chmod +x /home/user/Desktop/monero-gui.desktop && \
    chown user:user /home/user/Desktop/monero-gui.desktop

# Copy Monero GUI icon and new background image to correct directory:
COPY files/monero.png /usr/local/monero-gui/monero.png
COPY files/monero-wallpaper.jpg /usr/share/backgrounds/xfce/xfce-blue.jpg

# Copy my terminal preferences to the proper directory:
COPY files/terminalrc /home/user/.config/xfce4/terminal/terminalrc

# Change default user password and move Monero GUI Wallet PDF to Desktop:
RUN echo "user:password" | chpasswd && \
    ln -sf /usr/local/monero-gui/monero-gui-wallet-guide.pdf /home/user/Desktop

# Expose both ports:
EXPOSE 6080
EXPOSE 5900
