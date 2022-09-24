#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

# remove hash from line 154
sed -i "154s/.//" /etc/locale.gen

locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "aorus" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 aorus.localdomain aorus" >> /etc/hosts
echo root:password | chpasswd

pacman -S efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs bluez bluez-utils blueberry cups alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh firewalld ntfs-3g

pacman -s --noconfirm xf86-video-amdgpu

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld

useradd -m scott
echo scott:password | chpasswd
echo "scott ALL=(ALL) ALL" >> /etc/sudoers.d/scott

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
