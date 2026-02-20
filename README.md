---
title: README.md
---

# Endeavour OS Basics

This user guide overviews maintenance tasks for **Endeavour OS** systems, relevant terminal commands, general user tools, and links to additional resources.

---

## Overview 

[eos-logo]: /wiki/images/endeavouros-logo-text-dark.svg
![Endeavour OS logo and text for a dark background][eos-logo]

[Endeavour OS][eos] is a resource-light and terminal-centric Linux distribution based on [Arch Linux][arch]. It provides a beginner-friendly setup option (via the Calamares tool) along with the classic Arch installation process for power users.

Linux systems are highly customizeable but require more hands-on maintenance to run smoothly. Users should regularly:

 1. **Back up** system files

 2. **Update** important programs

 3. **Clean** out unused files

Through several terminal commands, users can upgrade essential packages, obtain new program features, and ensure system stability and security.

> [!NOTE]\
> This repository is a personal reference for my setup and experience with Endeavour OS. In addition to basic wiki guides and a maintenance cheatsheet, this repo contains custom scripts that can be used as general tools and program shortcuts.

<!-- links -->
[arch]: https://archlinux.org/
[eos]: https://endeavouros.com/

---

## Quicklinks

- [README][readme]
- [Wiki homepage][wiki]

<!-- quicklinks -->
[gh-pages]: https://mghwajin.github.io/eos-basics/index.html
[readme]: https://github.com/mghwajin/eos-basics/blob/main/README.md
[wiki]: https://github.com/mghwajin/eos-basics/wiki
[eos]: https://endeavouros.com/

### System maintenance and setup

| System Maintenance        | User Tools & Setup           |
| ------------------------- | ---------------------------- |
| [Overview][1]             | [Change login background][7] |
| [Back up system files][2] | [Copy cursor selection][8]   |
| [Clean unused files][3]   | [Enable `cron` scheduler][9] |
| [Update system packages][4] | [Use `git clone`][10]      |
| [Update mirrors][5]         | ---                        |
| [Resolve conflicting configs][6] | ---                   |

<!-- wiki links -->
[1]: https://github.com/mghwajin/eos-basics/wiki/system-maintenance-overview
[2]: https://github.com/mghwajin/eos-basics/wiki/create-system-backups-with-timeshift
[3]: https://github.com/mghwajin/eos-basics/wiki/clean-unused-system-files
[4]:https://github.com/mghwajin/eos-basics/wiki/system-updates-with-pacman-and-yay
[5]: https://github.com/mghwajin/eos-basics/wiki/mirror-maintenance-guide
[6]:https://github.com/mghwajin/eos-basics/wiki/resolve-conflicting-config-files

[7]: https://github.com/mghwajin/eos-basics/wiki/change-login-background
[8]: https://github.com/mghwajin/eos-basics/wiki/copy-cursor-selection-to-clipboard
[9]: https://github.com/mghwajin/eos-basics/wiki/enable-the-cron-scheduler
[10]: https://github.com/mghwajin/eos-basics/wiki/git-clone-to-location

---

## Custom scripts

| Script                         | Description           |
| ------------------------------ | --------------------- |
| [Autosave dated screenshot][a] | Requires `xfce4-screenshooter`. Instantly and automatically save a fullscreen screenshot with the date appended to the filename. Running this script bypasses the window waiting for filename input from the user. |
| [Convert video file to MP3][b] | Requires `ffmpeg` and `thunar` file manager. Runs a custom action in `thunar` to convert a selected video file into an `.mp3` file. This script sets `ffmpeg` to use VBR (variable bit rate) for the highest possible audio quality for conversion. |

<!-- script links -->
[a]: /scripts/xfce4-screenshooter-autosave.sh
[b]: /scripts/thunar-convert-to-mp3.sh

**General tips**
- Scripts may require adjustments to function properly on your system's setup. For example, a script referencing `/home/some-username` should be edited to match your `/home/user` directory.

- Create a `/home/user/bin` directory to place your custom scripts for easy file access, consistency, and organization.

- Be sure to set the script as an executable file with the `chmod` command: `chmod +x script.sh` 

---

## Official resources
Official **Endeavour OS** resources and links to additional information:

| Link                 | Description            | 
| -------------------- | ---------------------- | 
| [Official site][eos] | The official Endeavour OS site where you can download and verify ISO images for installation. |
| [Ganymede][ganymede] | The new Ganymede ISO was released on November 29, 2025. |
| [EOS README][eos-rm] | Where you can find important news and EOS updates.      |
| [Knowledge base][kb] | Library of various tutorials, troubleshooting guides, and intros to Linux tools. |
| [EOS forums][forums] |  A place to read up on EOS system updates, ask for troubleshooting help, and connect with the user community. |
| [Arch wiki][arch-wiki] | Wiki with detailed articles and common troubleshooting cases for Arch-related programs and processes. |
| [Distrowatch][distro]  | Comprehensive Linux resource center that includes a weekly newsletter and Linux terms glossary. |

**Credits**
- [Endeavour OS Branding][brand]
- [Endeavour OS Development][dev]

<!-- official links -->
[arch-wiki]: https://wiki.archlinux.org/title/Main_page
[distro]: https://distrowatch.com
[brand]: https://github.com/endeavouros-team/Branding
[dev]: https://github.com/endeavouros-team
[forums]: https://forum.endeavouros.com/
[kb]: https://discovery.endeavouros.com/
[eos-rm]: https://gitlab.com/endeavouros-filemirror/Important-news/blob/main/README.md
[ganymede]: https://endeavouros.com/news/the-long-wait-is-over-ganymede-has-arrived/

---

```
Revision history
    2026/02 - Major restructuring, consolidate w/ custom scripts
    2026/01 - Typo and formatting fixes
    2025/12 - Added glossary, command cheatsheet, and Ganymede ISO info
    2025/11 - Rework of docs content and structure
```

<!-- EOF -->