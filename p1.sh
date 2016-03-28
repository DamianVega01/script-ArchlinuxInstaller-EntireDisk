#dentro del live pasando archivos al SO recien creado
#fstab anulado hasta resolver deposicion de directorios
#echo "generando fstab "
#genfstab -U /mnt > /mnt/etc/fstab
echo "generando carpeta script dentro SO nuevo "
mkdir /mnt/root/Mscript
#primer fichero
echo " moviendo script  a nuevo So en /etc/home/Mscript "
cp /root/script/DentroSN.sh /mnt/root/Mscript
echo " moviendo mkinicipio a nuevo So en /etc/home/Mscript "
#segundo fichero
cp ~/script/mkinitcpioScript.conf /mnt/root/Mscript
echo " moviendo grubScriptt a nuevo So en /etc/home/Mscript "
#tercer fichero
cp ~/script/grubScript /mnt/root/Mscript
#4to fichero 
echo " moviendo lvmScript.conf a nuevo So en /etc/home/Mscript "
cp ~/script/lvmScript.conf /mnt/root/Mscript

echo " moviendo p2.sh a nuevo So en /etc/home/Mscript "
cp ~/script/p2.sh /mnt/root/Mscript

echo " entrando en root del sistema "
arch-chroot /mnt /bin/bash 
echo "intentando ejecutar script en SO nuevo "
#sudo sh /home/script/DentroSN.sh

#echo "generando local locales "
#locale-gen
#echo " reloj del sistema local "
#hwclock --systohc --utc

#mv /home/scripts/mkinitcpioScript.conf /etc/mkinitcpio.conf
#echo " generando kernel "
#mkinitcpio -p linux


