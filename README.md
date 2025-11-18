# 💻 Endeavour OS Basics

This example guide\* contains basic troubleshooting, system maintenance, and setup guides for beginner to intermediate users of [Endeavour OS](https://endeavouros.com/).

\*For my personal reference. May contain errors.

# Contents

[General info and resources](#general-info)

[Pacman update errors and troubleshooting](#pacman-troubleshooting)

- [GPGME error: No data](#gpgme-error)

- [Errors/Warnings from xyz.abc.mx (mirrorlist)](#mirrorlist-errors)

- [/etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew](#pacman-installed-as-pacnew)

[System maintenance](#system-maintenance)

- [Create system backups](#create-system-backups)

- [Update system](#pdate-system)

- [Update mirrors](#update-mirrors)

- [Clear unused files](#clear-unused-files) 

[xfce4-screenshooter functionality](#xfce4-screenshooter) 

[Other topics](#other)

# General info and resources {#general-info}
---
# 🔎 Pacman updates troubleshooting {#pacman-troubleshooting}

## GPGME error: No data/failed to synchronize all databases {#gpgme-error}
### GPGME and GnuPG
### Errors/warnings from xyz.abc.mx (mirrorlist) {#mirrorlist-errors}

## /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew {#pacman-installed-as-pacnew}
---
# ⚙️ System maintenance {#system-maintenance}

## 💾 Create system backups {#create-system-backups}
### sudo timeshift --check or --create {#timeshift}
### Current Timeshift settings (personal)
---
## 🔧 Update system {#update-system}

### sudo pacman -Syu  {#sudo-pacman-syu}

### yay  {#yay}
#### What is yay?
#### Which update command should I run?

### eos-pacdiff  {#eos-pacdiff}
### Pacnew & Pacsave {#pacnew-pacsave}
### Pacdiff & meld {#pacdiff-meld}
---
## 🔧 Update mirrors {#update-mirrors}

### reflector-simple / eos-rankmirrors  {#rerank-mirrors}
#### Update Arch mirrors {#update-arch-mirrors}
#### Update EOS mirrors {#update-eos-mirrors}

### Alternative mirror configurations {#alternative-mirror-configs}
#### Reflector
#### Ghostmirror
---
## 🗑️ Clear unused files {#clear-unused-files}

### journalctl \-vacuum-time=6weeks  {#journal}

### paccache \-r  {#paccache}

### pacman \-Qdtq | pacman \-Rns \-  {#pacman-orphans}
---
# 🎥 xfce4-screenshooter functionality {#xfce-screenshooter}

## Mouse selection to clipboard {#mouse-selection-to-clipboard}

## Auto-save fullscreen screenshot {#auto-save-fullscreen-screenshot}
---
# 📂 Other topics {#other}

## git clone into a specified location {#git-clone}

## Change login screen background {#login-background}

## Nvidia-settings configuration not saving/applying {#nvidia-settings-config}

















