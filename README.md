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

## Fin d'installation
```
cd
umount mymount
poweroff
```

## Lancement du script
```
./script_install [partition boot] [partition root]
```

# Post-installation
Brancher le disque de backup
```
sudo ./post_install
```
# Pour rollback
```
cryptsetup open /dev/[partition root] system
mount /dev/mapper/system /mnt

mv /mnt/root /mnt/broken_root
btrfs subvol snapshot /mnt/snapshots/[N]/snapshot/ /mnt/root

umount /mnt
cryptsetup close system
poweroff
```
Où N est le numéro du snapshot
