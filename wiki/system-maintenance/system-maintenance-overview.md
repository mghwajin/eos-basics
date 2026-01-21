<!------------------------------------->

# System maintenance overview
Arch-based distros like EOS have **rolling release** updates to keep up with the latest feature releases. Users should regularly run maintenance tasks to keep the system clean and up to date.

Quick resources
- [Key terms glossary](#key-terms-glossary)
- [Maintenance cheatsheet](#maintenance-cheatsheet)

Guides
- [Clean unused system files](clean-unused-system-files)
- [Create system backups with `timeshift`](create-system-backups-with-timeshift)
- [System updates with `pacman` and `yay`](system-updates-with-pacman-and-yay)
- [Mirror maintenance guide](mirror-maintenance-guide)
- [Resolve conflicting config files](resolve-conflicting-config-files)

<!--------------------------------------------->

## Key terms glossary
| Term | Description |
|:-----|:------------|
| Arch Linux | A rolling-release distribution of Linux that is known for its bleeding-edge and customizeable environment. It uses the `pacman` package manager and AUR packages. |
| AUR | The *Arch User Repository* is a large library containing many useful tools that are created and maintained by the Arch community. Popular and well-maintained packages are voted on by the community to include in the official Arch *extra* repository. |
| Command-line interpreter | Also known as the CLI or shell, this is the layer where users enter text commands for the system to execute. On Linux, common shells include Bash and Zsh. |
| Configuration files | These files are found in the /etc (or user's home) directory for program or system settings. |	
| Distro/distribution | An operating system that is based off a Linux kernel (which can vary) that comes with specific packages, a package manager, default desktop environments, and other system settings. EndeavourOS is an Arch-based distro. |	
| Display manager | This sets up the system's login screen and interface, and also launches the desktop session. |
| GUI tool| A graphical tool that provides a visual interface to apply command line options. This is also called a "GUI wrapper". |	
| GnuPG | [GnuPG](https://www.gnupg.org/documentation/index.html) is a command-line interface (CLI) tool. As a universal crypto engine, it is often used as the crypto backend for many applications.|
| GPGME	| The [GPGME](https://www.gnupg.org/software/gpgme/index.html) (or GnuPG Made Easy) library is used to provide applications easier access to GnuPG functions. |
| Greeter | This is the UI portion of the display manager that accepts and verifies user credentials. This can also customize the login screen. |	
| Mirror | Mirrors are servers located around the world that store copies of original software repositories. This allows users to access files without overburdenening the one original source. Mirrors are "re-ranked" to update the mirrorlist with ones that were most recently updated with new package files. |	
| Mirrorlist | A mirrorlist is a list containing important information about a mirror, such as the access link, when it was last updated (age), how fast the mirror download speed is (rate), and where it is located. When re-ranking mirrors, the mirrorlist is updated with information for newer mirrors. |
| Orphan dependencies | Orphans are dependencies that are no longer needed by any program. This accumulate when packages are installed without removing dependencies, or if an updated package no longer requires it (when it originally did). |
| Package | A collection of files that are used as a library, an application, driver software, etc. that the system's package manager can install, uninstall, upgrade, or remove. |
| Package dependency | Dependencies are additional packages or libraries required for a specific software to build, run, and maintain a stable and secure runtime. |	
| Package manager | This system tool is what downloads, installs/uninstalls, upgrades, and verifies packages. Arch-based systems use the `pacman` package manager. |
| Rolling-release | These are unscheduled updates that are continuously released, usually as soon as they are available. These updates are smaller and more frequent (with the chance to run into some issues), which means the user doesn't have to install a large update 1-2 times a year.|
| Shell | Also known as the CLI (command-line interpreter), this is the layer where users enter text commands for the system to execute. On Linux, common shells include Bash and Zsh. |
| System daemon	| A background service/process that starts upon system boot (or on user demand) and provide important functions suchs as timed scheduling (ex. system backups) and logging (like `systemd journal`). |
| Terminal | The interface that allows users to send commands and recieve text output from the computer system. Terminals emulate how users interacted with old-style physical computers by  dedicated hardware terminals. |
| Terminal command | An instruction entered into the command-line interface (CLI) that invokes the system or specific programs. These often include specific options.  |	
| Timeshift | A system backup utility tool that created "snapshots" (RSYNC or BTRFS files). By default, it saves important system settings and config files, allowing users to restore to a previous state if the current one is unbootable. |

<!--------------------------------------------->

## Maintenance cheatsheet

Below is a quick reference table of common maintenance commands and the recommended usage frequency.

| Command | Usage | Recommended frequency |
|:--------|:------|:----------------------|
|`sudo timeshift --create` or `--check` | `create` an unscheduled system snapshot, or `check` first and generate one if a scheduled snapshot is due | Daily, before making system changes |
|`sudo pacman -Syu`| Syncs, refreshes, and updates packages to newest versions | Daily |
| `sudo pacman -Rns <package>` or `yay -Rns <package>` | Uninstalls and removes a package and its dependencies | As needed | 
|`yay` | Updates core system packages. Can also run `eos-update --aur` | Every 1-2 weeks | 
|`eos-update` | Updates EOS-specific core packages | Every 1-2 weeks | 
|`eos-pacdiff` | Notifies user of any conflicting configs, then calls `pacdiff` and `meld` to assist with merges. Same function as `DIFFPROG=meld pacdiff -s` | At system prompt | 
|`DIFFPROG=meld pacdiff -s` | Uses `pacdiff` tool and `meld` GUI to assist the user with merging config files. Same function as `eos-pacdiff` | At system prompt | 
|`reflector-simple` | Runs `reflector` with a GUI assistant to generate an updated Arch `mirrorlist` | Every 1-2 months | 
|`eos-rankmirrors` | Generates a new EndeavourOS `mirrorlist` ranking the latest 20 mirrors by rate | Every 2-3 months |
|`paccache -r` | Clear `pacman` cache of uninstalled packages, maintaining the last 3 versions | Every 1-2 months | 
| `yay -Sc` | Clear the `yay` cache | As needed |
|`journalctl --vacuum-time=6weeks` | Clear the `systemd` journal and retain logs for the past 6 weeks | Every 1-2 months
|`sudo pacman -Qdtq \| sudo pacman -Rns -` | Lists orphaned dependencies (`pacman -Qqtd`), then removes with user confirmation (`sudo pacman -Rns -`) | Every 1-2 months |
|`eos-shifttime` | A temporary solution to revert to a system status at a set date, which may be useful if a recent update causes issues with a program. | As needed |

---

> [!TIP] 
> 
> For users unfamiliar with terminal usage or needing quick system fixes, the [**EOS Welcome App**](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) Assistant is a helpful alternative to running maintenance tasks.

Open the **Welcome App** from System Applications, or with the `eos-welcome` terminal command.

![EOS Welcome program v25.10.3-1 with a list of update scripts on the Assistant tab.](./images/eos-welcome.png)

---

<!-- EOF -->
