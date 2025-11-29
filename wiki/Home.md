#  Endeavour OS Beginner Basics
<div style="text-align: center;">

![Endeavour OS logo and text for a dark background](./images/endeavouros-logo-text-dark.png)

</div>

## Introduction
[**Endeavour OS**](https://endeavouros.com/) is an resource-light and terminal-centric Linux distribution based on [Arch Linux](https://archlinux.org/). It provides a beginner-friendly setup experience alongside the classic Arch installation process for power users.

This intermediate-beginner's guide covers the basics of how to update and maintain [**Endeavour OS**](https://endeavouros.com/) using **terminal commands** in the **command-line interface** (CLI).

Review the [additional resources section](#additional-resources) for links to official documentation on Endeavour OS, community forums, and relevant wikis.


## Table of Contents
<details open> 
    <summary> </summary>

- [Introduction](#introduction)
- [Commands cheat sheet](#commands-cheat-sheet)
- [Additional Resources](#additional-resources)
- [**`Pacman`** troubleshooting](pacman-troubleshooting)
- [System maintenance guide](system-maintenance-guide)
- [Other topics](other-topics)
<!-- TO DO: [Install Endeavour OS](install-eos) -->


</details>


## Commands cheat sheet
This section contains all commands covered in the system maintenance and `pacman` troubleshooting guides. Click on links in the command descriptions to see detailed information.

<details open>
    <summary><b>Install or update system packages</b></summary>

| Command   | Description   |              
|:----------|:--------------|
|`sudo pacman -Syu` | Synchronize with package database and refresh the masterlist, then check for and update outdated packages |
|`sudo pacman -Syy` | Refresh the local cache, which can rebuild removed files |

|`sudo pacman -Qdtq \| sudo pacman -Rns -` | Search for and display a list of orphans (unused package dependencies) to remove upon user confirmation |
|`sudo pacman -D --asexplicit package-name`| Specify an orphan package to exclude from the removal process |
|`paccache -r` | Clear the `/var/cache/pacman/pkg` cache of uninstalled packages, maintaining the last 3 versions |
|`paccache -ruk0` | Clear the `/var/cache/pacman/pkg` cache of ALL versions of uninstalled packages | 
|`yay` | Update the system's core AUR and native (distribution) packages |

| Manage system packages | Description  |
|:-----------------------|:-------------|
|`sudo rm -R /var/lib/pacman/sync` | Remove the `/pacman/sync` file using root permissions |
|`pacman -U package_name-version-1.0.1.pkg.tar.zst` | Build and install the specified package |
|`pacman -Rs package-name` | Remove an uninstalled package and its unused dependencies |
| | |
| | |

</details>

| Back up system settings/files | Description   |
|:---------------------|:--------------|
|`sudo timeshift --create` | |
|`sudo timeshift --check` | |

| Manage system `daemons` | Description |
|:------------------------|:------------|
|`sudo systemctrl status example.service` | |
|`sudo systemctl enable example.service` | |
|`sudo systemctl stop example.service` | |
|`sudo systemctl disable example.service` | |

| Update `mirrorlists` | Description    |
|:-------------------------|:---------------|
|`reflector-simple` | |
|`reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist` | |
|`eos-rankmirrors` | |
|`yay -Syyu` | Refresh the system's masterlist of package databases. Always run this after a `mirrorlist` update |

| Clear unused packages/files | Description |
|:----------------------------|:------------|
|`journalctl` | |
|`journalctl --vacuum-time=6weeks` | |
|`paccache -r` | |
|`sudo pacman -Qdtq \| sudo pacman -Rns -` | |


## Additional resources
Additional information and learning resources are available at the following links:

- [Mercury Neo 6.13.7](https://endeavouros.com/news/mercury-neo-with-linux-6-13-7-and-arch-mirror-ranking-bug-fix/) \- The most recent ISO release of EOS, released on March 23, 2025.
- [EOS README](https://gitlab.com/endeavouros-filemirror/Important-news/blob/main/README.md) \- Where you can find important news and EOS updates
- [EOS knowledge base](https://discovery.endeavouros.com/) \- A library of various tutorials and introductions to Linux tools
- [EOS forums](https://forum.endeavouros.com/) \- A place to read up on EOS system updates, ask for troubleshooting help, and connect with the community
- [Arch Linux wiki](https://wiki.archlinux.org/title/Main_page) \- A wiki with detailed articles and common troubleshooting cases for Arch-related programs and processes
- [DistroWatch](https://distrowatch.com/) \- A comprehensive Linux resource center that includes a weekly newsletter and terms glossary.

[Top of page](#Endeavour OS System Maintenance for Beginners)



```bash
                                    [----c o o o o o o ]
This guide is a work in progress!!  [-----Co o o o o o ]
                                    [------c o o o o o ]
```
---

Revision History



> [!NOTE]

> [!TIP]

> [!WARNING]

> [!CAUTION]

> [!IMPORTANT]


---
<!-- EOF -->