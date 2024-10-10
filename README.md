# Mon script d'installation d'arch linux

## But : Script d'installation avec:
### Btrfs
### Luks
### Systemd-boot
### Swayfx

# Procédure

## Définir le clavier
```
loadkeys fr-bepo
```

## Définir la font du terminal (optionnel)
```
setfont ter-132b
```

## Définir un mot de passe à root (optionnel)
```
passwd
```

## Se connecter en ssh (optionnel)
```
ssh root@[ip]
```

## Monter le stockage de ventoy pour accéder au script
```
mount -m /dev/sdb4 mymount
cd mymount/my_arch_install
```

## Créer une partition boot et une autre qui sera le système principale
- Une partition de 1G de type EFI System
- Une partition de type Linux filesystem
```
cfdisk
```

## Lancement du script
```
./script_install [partition boot] [partition root]
#exemple
./script_install sda1 sda2
```

## Fin d'installation
```
cd
umount mymount
poweroff
```

# Post-installation
Brancher le disque de backup
```
sudo ./post_install
```
# Pour rollback
```
#cryptsetup open /dev/[partition root] system
cryptsetup open /dev/sda2 system
mount /dev/mapper/system /mnt

number=N # Le numéro du snapshot
mv -f /mnt/root /mnt/broken_root
btrfs subvol snapshot /mnt/snapshots/$number/snapshot/ /mnt/root

number=N # Le numéro du snapshot
mv -f /mnt/home/adrien /mnt/home/broken_adrien
btrfs subvol snapshot /mnt/home/.snapshots/$number/snapshot /mnt/home
mv /mnt/home/snapshot/adrien /mnt/home/adrien
rm -fr /mnt/home/snapshot

umount /mnt
cryptsetup close system
poweroff
```

# Chroot

## Déchiffrement du système
```
cryptsetup open /dev/$partition_systeme system
```
## Monter les sous-volumes btrfs
```
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=root /dev/mapper/system /mnt
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=home /dev/mapper/system /mnt/home
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=snapshots /dev/mapper/system /mnt/.snapshots
```
## Monter le boot
```
mount /dev/$partition_boot /mnt/boot
```
## Chroot
```
arch-chroot /mnt
```
## Démonter tout
```
umount -R /mnt
```
## Fermer le chiffrement du système
```
cryptsetup close system
```


