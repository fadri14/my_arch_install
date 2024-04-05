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
- Paramètre 1 : la partition boot
- Paramètre 2 : la partition système
```
./script_install sda1 sda2
```

# Post-installation
Brancher le disque de backup
```
sudo ./post_install
```
# Pour rollback
```
cryptsetup open /dev/[partition] system
mount /dev/mapper/system /mnt
mv /mnt /mnt/broken_root
btrfs subvol snapshot /mnt/root/ /mnt/.snapshots/[N]/snapshot/
btrfs subvol snapshot /mnt/.snapshots/[N]/snapshot/ /mnt
```
Où N est le numéro du snapshot
