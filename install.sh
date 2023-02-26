#!/bin/sh
(
## Installing progams
sudo xbps-install -Su nerd-fonts-ttf android-tools elogind zsh-syntax-highlighting zsh-autosuggestions sway xorg-server-xwayland virt-manager libvirt qemu curl make pulsemixer qbittorrent ufw polkit polkit-elogind dbus-elogind ntp wireplumber firefox kitty mpv yt-dlp pipewire papirus-icon-theme alsa-pipewire libva-intel-driver rofi playerctl dash go zsh noto-fonts-emoji font-ibm-plex-ttf xorg-fonts neovim opendoas yarn pnpm wl-clipboard 

wget https://cdn.pixabay.com/photo/2018/08/13/21/52/nature-3604097_960_720.jpg

) > /dev/null 2>&1
echo '##                        (13%)\r'
sleep 1
(
## Moving folders
mv $HOME/Vrice/config/.config/ $HOME/.config && mv $HOME/Vrice/config/.zshrc /$HOME/.zshrc &&
mv $HOME/Vrice/config/.zshnev /$HOME/.zshnev && sudo mv $HOME/Vrice/config/pexelsmaxime-francis-2246476.jpg /etc/sway/back.png

## Installing vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		 ) > /dev/null 2>&1

## Symlinking dash as /bin/sh
sudo ln -sfT dash /usr/bin/sh
echo '#####                     (33%)\r'
sleep 1

(## Changing user shell to zsh
sudo chsh -s /usr/bin/zsh marcioc

## Neovim configuration
sudo cp -r $HOME/.config/nvim/ /root/.config/
) > /dev/null 2>&1
echo '#######                   (45%)\r'
sleep 1
(
## Symlinking shit
sudo ln -s /etc/sv/polkit /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/libvirtd /var/service
sudo ln -s /etc/sv/virtlockd /var/service
sudo ln -s /etc/sv/virtlogd /var/service

## Enabling ufw 
sudo ufw enable

## Making user part of the libvirt group
sudo usermod -aG marcioc libvirt
) > /dev/null 2>&1
echo '#############             (66%)\r'
sleep 1
(
## Configuring pipewire
sudo mkdir -p /etc/alsa/conf.d && 
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && 
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

## Enabling doas
touch doas.conf && echo permit nopass marcioc as root > doas.conf &&
sudo mv doas.conf /etc/ && sudo chown root:root /etc/doas.conf
) > /dev/null 2>&1
echo '###############           (83%)\r'
sleep 1

(
## Enabling doas
touch 51-android.rules 
sudo mkdir /etc/udev/rules.d/
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="[ff48]", MODE="0660", GROUP="adbusers", TAG+="uaccess"
SUBSYSTEM=="usb", ATTR{idVendor}=="[ff48]", ATTR{idProduct}=="[2717]", SYMLINK+="android_adb"
SUBSYSTEM=="usb", ATTR{idVendor}=="[ff48]", ATTR{idProduct}=="[2717]", SYMLINK+="android_fastboot"' > 51-android.rules 
sudo mv 51-android.rules /etc/udev/rules.d/ && sudo chown root:root /etc/udev/rules.d/51-android.rules
) > /dev/null 2>&1

echo '#######################   (100%)\r'
echo '\n'

echo Done.
