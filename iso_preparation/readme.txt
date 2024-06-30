Notes taken during preparation of boot image

Main guide that was followed
https://www.pugetsystems.com/labs/hpc/ubuntu-22-04-server-autoinstall-iso/

used apt 'install p7zip-full' to install 7z

based user-data on content of /var/log/installer/autoinstall-user-data of server configured via manual install for use in
Atomika

tweaked according to https://www.pugetsystems.com/labs/hpc/ubuntu-22-04-server-autoinstall-iso/ and references below

created image with
root@atomika:/iso/u22.04-autoinstall-ISO# xorriso -as mkisofs -r   -V 'Ubuntu 22.04 LTS AUTO (EFIBIOS)'   -o ../ubuntu-22.04-atomika-autoinstall.iso   --grub2-mbr ../BOOT/1-Boot-NoEmul.img
-partition_offset 16   --mbr-force-bootable   -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b ../BOOT/2-Boot-NoEmul.img   -appended_part_as_gpt   -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7   -c '/boot.catalog'   -b '/boot/grub/i386-pc/eltorito.img'     -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info   -eltorito-alt-boot   -e '--interval:appended_partition_2:::'   -no-emul-boot   .

Additional references
https://linuxconfig.org/how-to-write-and-perform-ubuntu-unattended-installations-with-autoinstall
https://discourse.ubuntu.com/t/automated-server-installer-config-file-reference/16613
https://www.gnu.org/software/grub/manual/grub/grub.html#Loading-an-operating-system-directly
