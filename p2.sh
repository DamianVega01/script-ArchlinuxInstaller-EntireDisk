# por mtivos de pruebas desactivo pacman
#y | pacman -Syu iw  wpa_supplicant dialog networkmanager net-tools pkgfile 
echo "instalando XORG y sus complementos"
pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils
echo " instalando mesa mesa-demos "
sudo pacman -S mesa mesa-demos


echo " instalar drivers  "
echo "1)  Virtualbox  "
echo "2) nvidia  "
echo "3) no instalar nada  "
read tecla
case $tecla in
1) 
y | pacman -Syu virtualbox  virtualbox-guest-modules
#virtualbox-guest-utils  
#virtualbox-guest-modules 
modprobe -a vboxguest vboxsf vboxvideo 

echo vboxguest > /etc/modules-load.d/virtualbox.conf
echo vboxsf >> /etc/modules-load.d/virtualbox.conf
echo vboxvideo >> /etc/modules-load.d/virtualbox.conf

#VBoxClient --clipboard --draganddrop --seamless --display --checkhostversion
#VBoxClient-all
systemctl enable vboxservice
echo /usr/bin/VBoxClient-all >> ~/.xinitrc
echo " instalando mesa mesa-demos "
sudo pacman -S mesa mesa-demos
;;

2)
 pacman -S nvidia-304xx lib32-nvidia-libgl;;

*)
break;;

esac


