
# Arch install script for usb

# Introduction | Get User Inputs

echo -e "Welcome to the Arch USB Installer"

echo "If you have not already, please connect to the internet before running the script."

read -p "Cancel Install Now? y/N: " cancel

echo "$cancel"

# Fixing the condition to check for cancellation
if [[ "$cancel" == "y" || "$cancel" == "Y" || "$cancel" != "" ]]; then
    exit 1
fi

read -p "Enter timezone region: " region
read -p "Enter timezone city: " city

timedatectl set-timezone "${region}/${city}"

echo -e "Choose a drive"

lsblk

echo -e "Choose the drive and enter below (e.g. '/dev/sdb')."

read -p "Enter here: " drive

sgdisk -o -n 1:0:+10M -t 1:EF02 -n 2:0:+500M -t 2:EF00 -n 3:0:0 -t 3:8300 "$drive"

echo -e "Creating File Systems"

mkfs.fat -F32 "${drive}2"

mkfs.ext4 "${drive}3"

echo -e "Mounting File System"

mkdir -p /mnt/usb
mount "${drive}3"

mkdir -p /mnt/usb/boot
mount "${drive}2" /mnt/usb/boot

echo -e "Installing Base System"

pacstrap /mnt/usb linux linux-firmware base vim

genfstab -U /mnt/usb > /mnt/usb/etc/fstab

echo -e "Entering Chroot Environment"

arch-chroot /mnt/usb

ln -sf "usr/share/zoneinfo/${region}/${city}/" etc/localtime

sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

hwclock --systohc

read -p "Enter Hostname: " hostname

echo "$hostname" > /etc/hostname

passwd

pacman -S grub efibootmgr

grub-install --target=i386-pc --recheck /dev/sdX
grub-install --target=x86_64-efi --efi-directory /boot --recheck --removable

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable systemd-networkd.service

pacman -S iwd

systemctl enable iwd.service
systemctl enable systemd-resolved.service
systemctl enable systemd-timesyncd.service

read -p "Enter Username: " user

useradd -m "$user"
passwd "$user"

groupadd wheel
usermod -aG wheel "$user"

pacman -S sudo

groupadd sudo
usermod -aG sudo "$user"

pacman -S polkit

reboot






