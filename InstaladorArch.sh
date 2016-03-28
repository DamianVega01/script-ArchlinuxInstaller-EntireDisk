#! bin/bash

clear
echo "|--------------------------------------------------------|" 
echo "|  Mi script de instalacion de arch con grub encriptado  |" 
echo "|--------------------------------------------------------|" 
echo "                                                          "
echo " Rescribiendo disco con informacion aleatoria "
#dd if=/dev/urandom of=/dev/sda
echo "    configurando teclado y locales "
loadkeys la-latin1
echo es_AR.UTF-8 > /etc/locale.conf
locale-gen
echo LANG="es_ES.UTF-8" > /etc/locale.conf
echo "                                                          "
echo "        Encriptacion de disco completo      "
echo "                                                          "
cfdisk /dev/sda
parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary 2048s 100%
echo " escribir passwrd "
cryptsetup -c aes-xts-plain -y -s 512 luksFormat /dev/sda1
echo " volver a escribir passwd para abrir contenedor"
cryptsetup luksOpen /dev/sda1 lvm
pvcreate /dev/mapper/lvm
vgcreate vg /dev/mapper/lvm
echo "  creando las particiones y el mapa "
echo " escriba en gigas el tamaño de la particion swap"
#read num
lvcreate -L 2G vg -n swap
echo " escriba en gigas el tamaño de la particion root"
#read num
lvcreate -L 10G vg -n root
echo " la particion home se crea con el espacio restante"
#read tecla
lvcreate -l +100%FREE vg -n home
mkswap -L swap /dev/mapper/vg-swap
mkfs.ext4 /dev/mapper/vg-root
mkfs.ext4 /dev/mapper/vg-home
echo " montando las particiones logiscas "
mount /dev/mapper/vg-root /mnt
mkdir /mnt/home
mount /dev/mapper/vg-home /mnt/home
echo " wifi menu "
wifi-menu
echo " dhcp "
read tecla
dhcpcd
echo " instalando sistema base "
#read tecla
pacstrap /mnt base base-devel
echo "generando fstab "
genfstab -U /mnt > /mnt/etc/fstab
echo "generando carpeta script dentro SO nuevo "
mkdir /mnt/home/Mscript
#primer fichero
echo " moviendo script  a nuevo So en /etc/home/Mscript "
cp /root/scripts/MisScripts/DentroSN.sh /mnt/home/Mscript
echo " moviendo mkinicipio a nuevo So en /etc/home/Mscript "
#segundo fichero
cp /root/scripts/MisScripts/mkinitcpioScript.conf /mnt/home/Mscript
echo " moviendo grubScriptt a nuevo So en /etc/home/Mscript "
#tercer fichero
cp /root/scripts/MisScripts/grubScript /mnt/home/Mscript
#4to fichero 
echo " moviendo lvmScript.conf a nuevo So en /etc/home/Mscript "
cp /root/scripts/MisScripts/lvmScript.conf /mnt/home/Mscript


echo " entrando en root del sistema. ejecutar /home/Mscript/DentroSN.sh "
arch-chroot /mnt /bin/bash
echo "      funcionara ??    "

#echo " sistema instalado, agregando hooks "
#cp /home/scripts/mkinitcpioScript.conf /etc/mkinitcpio.conf
#echo " generando kernel "
#scp mkinitcpio -p linux



