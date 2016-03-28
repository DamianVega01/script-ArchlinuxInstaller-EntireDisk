#
#echo " dentro del script dentroSN.h"
#echo "presionar cualquier tecla para continuar "
#read tecla
#echo "generando local locales "
#locale-gen
echo " reloj del sistema local "
hwclock --systohc --utc
echo " configurando el nombre del equipo a satub "
echo satub > /etc/hostname
echo " cambiando el mkinitcipio con hooks de encriptado ~/mkinitcpioScript.conf "
#el segundo fichero que se tiene que mover
cp ~/Mscript/mkinitcpioScript.conf /etc/mkinitcpio.conf
# pruebo wliminar Mscript y lo dejo con ~ a ver si sirve
cp ~/mkinitcpioScript.conf /etc/mkinitcpio.conf
echo " creando img linux "
mkinitcpio -p linux
#el 3ro que es el 4to fichero que se tiene que mover
echo " moviendo lvmetad 0 /etc/lvm.conf"
cp ~/Mscript/lvmScript.conf /etc/lvm.conf
echo " paso lvmtad ? "
#read tecla
## hasta ahora en teoria funciona bien sin haber tenido que configurar lvmetad
echo " descargando cosas xD "
pacman -S fuse grub lvm2 os-prober -y
echo " cambiando el grub por el que esta cpnfigurado /etc/default/grub"
#el 4to que es el 3ro fichero que se tiene que mover
cp  ~/Mscript/grubScript /etc/default/grub
echo "  grub-mkconfig "
grub-mkconfig -o /boot/grub/grub.cfg
echo " instando grub "
grub-install /dev/sda
echo " dejando el teclado en latino "
echo KEYMAP=La-latin1 > /etc/vconsole.conf
echo "ok, hasta aca funciona y reinicia ...  "
