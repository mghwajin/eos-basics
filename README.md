<!-- 
TO DO (20251117)
- add images for the steps with commented image descriptions
- review header ids for functionality
- hash out solutions for other topics in progress
-->
# 💻 Endeavour OS Basics
---
This example guide\* contains basic troubleshooting, system maintenance, and setup guides for beginner to intermediate users of [Endeavour OS](https://endeavouros.com/).

\*For my personal reference. May contain errors.
```
                            [---c o o o o o o o]
This guide is in progress!! [----Co o o o o o o]
                            [-----c o o o o o o]
```

# Contents
- [General information](#general-information)

- [Pacman updates troubleshooting](#pacman-updates-troubleshooting)

  - [GPGME error: No data](#gpgme-error-no-data)

  - [Mirrorlist errors/warnings](#mirrorlist-errors-warnings)

  - [xyz installed as xyz.pacnew](#xyz-installed-as-xyz-pacnew)

- [System maintenance](#system-maintenance)

  - [Create system backups](#create-system-backups)

  - [Update system](#update-system)

  - [Update mirrors](#update-mirrors)

  - [Clear unused files](#clear-unused-files)

- [xfce4-screenshooter](#xfce4-screenshooter)

- [Other topics](#other-topics)

# General information
[Endeavour OS](https://endeavouros.com/) (EOS) is an **open-source** and **resource-light** Linux distribution based on [Arch Linux](https://archlinux.org/).

Arch-based distros are **rolling-release** and release small system updates every day. Users can choose when to update and what parts of daily updates they would like to install, encouraging a freer user-customization experience.

This rolling-release structure additionally means users don't need to install major OS updates 1-2 times a year (as long as they update regularly).

[Mercury Neo 6.13.7](https://endeavouros.com/news/mercury-neo-with-linux-6-13-7-and-arch-mirror-ranking-bug-fix/), the latest major OS update, was released on March 23, 2025\.

Helpful information on EOS and additional learning resources are available at the following links:

- [EOS README](https://gitlab.com/endeavouros-filemirror/Important-news/blob/main/README.md) \- Where you can find important news and EOS updates

- [EOS knowledge base](https://discovery.endeavouros.com/) \- A library of various tutorials and introductions to Linux tools

- [EOS forums](https://forum.endeavouros.com/) \- A place to read up on EOS system updates, ask for troubleshooting help, and connect with the community

- [Arch Linux wiki](https://wiki.archlinux.org/title/Main_page) \- A wiki with detailed articles and common troubleshooting cases for Arch-related programs and processes

---
---

# Pacman updates troubleshooting
`pacman` is the package manager of Arch Linux and is used to install and update programs.

While `sudo pacman -Syu` performs a full system update and refresh, it may error out or only partially complete the upgrade process. Common errors include:
- [GPGME error: No data / failed to synchronize all databases](#gpgme-error-no-data)

- [Mirrorlist errors/warnings](#mirrorlist-errors/warnings)

- [xyz installed as xyz.pacnew](#xyz-installed-as-xyz-pacnew)

---

## GPGME error: No data
After attempting an update with `sudo pacman -Syu`, the terminal may output errors such as:

```
error: GPGME error: No data
error: failed to synchronize all databases (invalid or corrupted database (PGP signature))
```

These errors indicate that there is either an issue with the database itself, or that the system was unable to verify encryption keys of the package database.

**Remove and refresh** the `pacman sync` file  to fix this issue.

1. Open a terminal and remove the `pacman sync` file by entering: `sudo rm -R /var/lib/pacman/sync`

2. Refresh the local cache (i.e. rebuild the deleted file) with: `sudo pacman -Syy`

3. Reattempt `sudo pacman -Syu`

### GPGME and GnuPG
In this context, **GPGME** and **GnuPG** are used to securely encrypt/decrypt data from package databases.

- The [GPGME](https://www.gnupg.org/software/gpgme/index.html) library is used to provide applications easier access to **GnuPG** functions.

- [GnuPG](https://www.gnupg.org/download/index.html) is a command-line tool. As a **universal crypto engine**, it is often used as the **crypto backend** for many applications.

---

## Mirrorlist errors/warnings
**Mirrors** are servers located around the world that store copies of Linux distro software. A wide spread of **mirrors** helps to minimize any interruptions to services, and this information is stored in a **mirrorlist**.

During a `sudo pacman -Syu` update, the terminal may output **mirrorlist** errors or warnings.

```
error: failed retrieving file 'wine-10.17-1-x86\_64.pkg.tar.zst' from arch.jsc.mx : The requested URL returned error: 404
warning: too many errors from arch.jsc.mx, skipping for the remainder of this transaction
```

These issues are usually caused by **outdated mirrors** and can be fixed by **re-ranking** the mirrors.

1. Run `reflector-simple` to update Arch mirrors. You can choose mirror preferences, such as location and max amount, in the graphical interface that pops up.

  - Refresh your system after updating the mirrorlist with `yay -Syyu`

<!-- TO INSERT
*Image:Preference menu GUI that displays when using reflector-simple*
*Image: Preference menu that displays when using reflector-simple* 
-->

2. Run `eos-rankmirrors` to update EOS-specific mirrors. Information will display in the terminal.

  - Always refresh your system after updating the mirrorlist with `yay -Syyu`

Persistent issues despite re-reranking mirrors indicate an **outdated system**.  See [System maintenance: Update system](#update-system) to review how to keep your system up-to-date (ex. [`yay`](#yay)).

---

## xyz installed as xyz.pacnew
During a `sudo pacman -Syu` update, you may receive an error such as:

```
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

Resolve the conflicting configuration files with `eos-pacdiff`. It is highly recommended to resolve the conflicts ASAP to prevent further issues.

See [Update system: eos-pacdiff](#eos-pacdiff)

---
---

# System maintenance
To keep your EOS system healthy and up-to-date, it is recommended to regularly run maintenance commands. A quick overview of maintenance tasks is provided below.

- [Create system backups](#create-system-backups)

  - [sudo timeshift --check or --create](#sudo-timeshift-check-or-create)
  
- [Update system](#update-system)

  - [sudo pacman -Syu](#sudo-pacman--syu)
  
  - [yay](#yay)
  
  - [eos-pacdiff](#eos-pacdiff)
  
- [Update mirrors](#update-mirrors)

  - [reflector-simple/eos-rankmirrors](#reflector--simple-eos--rankmirrors)
  
- [Clean unused files](#clean-unused-files)

  - [journalctl](#journalctl)
  
  - [paccache -r](#paccache--r)
  
  - [pacman orphans](#pacman-orphans)

These maintenance tasks are run from the **command-line** and will back up system data, update programs, clean unused files, and more. The **EOS Welcome App** also comes with an assistant to help users easily run key maintenance scripts.

<!-- TO INSERT
*Image: EOS Welcome program v25.10.3-1 on the Assistant tab*
-->
---
---

## Create system backups
### sudo timeshift check or create

*Daily*

[timeshift](https://wiki.archlinux.org/title/Timeshift) creates a snapshot of **system files and settings**. It can be used to restore the system to a prior state if the current state becomes unbootable/unusable.

To save disk space, timeshift does not save any user files unless specifically directed to do so. Setting Timeshift to regularly save **non-system files will use a very large amount of disk space**.

- Generate a snapshot on demand with: `sudo timeshift --create`

- To create a snapshot only if one is due, use: `sudo timeshift --check`

In addition to daily backups, it is **highly recommended** to backup **before attempting to make any significant changes** to the system.
<!-- TO INSERT
*Image: Terminal output of Timeshift (v25.07.7) listing its syntax and options*
-->

---

### Current Timeshift settings
- **RSYNC snapshots** \- Creates copies of system files and hard-links unchanged files from the previous snapshot

- **Back up location** \- Saves to external /dev/nvme0n1p1 to allow for restore even if system disk is damaged. This is done via a liveboot system and restoring a selected snapshot

- **Saved data** \- Files/directories excluded to save disk space

- **Cron scheduler** ([cronie](https://archlinux.org/packages/extra/x86_64/cronie/)) \- Automatically takes snapshots when due, saving up to the designated number of snapshots per category.

  - The daemon must be **manually enabled** by running: `sudo systemctl enable cronie.service`

- **Snapshot limits** \- Once the number of snapshots reaches the set limit, timeshift deletes the oldest snapshot in the list. Current limits set to:
  - 4 monthly
  - 4 weekly
  - 7 daily
  - 5 hourly
  - 5 boot

See [Timeshift](https://wiki.archlinux.org/title/Timeshift) | [Cron](https://wiki.archlinux.org/title/Cron#Configuration)

---
---

## Update system

- [sudo pacman -Syu](#sudo-pacman--syu)

- [yay](#yay)

- [eos-pacdiff](#eos-pacdiff)

---

### sudo pacman -Syu

*Daily*

`pacman` is the package manager used to install and update programs in Arch Linux.

`sudo pacman -Syu` performs a **full system update and refresh**. It is recommended to run this daily, though user preference will vary.

<!-- TO INSERT
*Image: A terminal running sudo pacman -Syu, waiting for user confirmation to update packages*
-->
Other basic `pacman` commands include:

- `pacman -S package-name` \-  install specific package

- `pacman -Rs package-name` \- removes package and its unused dependencies

- `pacman -Syy` \- sync local database with online repositories before upgrading packages

- `pacman -Syyu` \- sync repositories and update system simultaneously

See [Pacman](https://wiki.archlinux.org/title/Pacman)

---

### yay

*Weekly*

Update the system's native and **AUR packages** (Arch User Repository) with one of the following:

- `yay`

- `eos-update --aur`

It is recommended to update the system on at least a semi-weekly basis.

#### What is yay?

[**yay**](https://aur.archlinux.org/packages/yay)AUR stands for "yet another yogurt" and it is one of the most popular **AUR helpers**.

**AUR helpers** simplify the process of downloading, installing, updating, and removing AUR software.

#### Which update command should I run?

This is up to personal preference. Some members of the EOS community recommend `eos-update` for a quick fix to the system.

Others prefer to run yay since it does all that is required without the additional script processes used in `eos-update --aur`.

See [yay](https://aur.archlinux.org/packages/yay)AUR | [Arch User Repository (AUR)](https://aur.archlinux.org/) | [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers)

---

### eos-pacdiff

*At system prompt*

The system notifies you whenever it detects **conflicting configuration files**.

```
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

These conflicts are generated when `pacman` creates copies of config files and prevents overwrite by appending `.pacsave` or `.pacnew` to the filename.

Resolve these conflicts with `eos-pacdiff` **ASAP**. Conflicting config files may prevent a program from functioning properly, or altogether.

1. When notified by the system about conflicting config files, run: `eos-pacdiff`

2. Select `V(iew)` to compare the config files side-by-side

3. Review the files for significant changes.

4. Remove, overwrite, or merge the differing lines as necessary.

**IMPORTANT!!  Always review files carefully before merging them**. Incorrect configurations may  break your system.

Refrain from modifying key system files such as `/etc/passwd`, `/etc/group`, and `/etc/shadow` unless you know what you're doing, otherwise you **may lock yourself out of your system.**


#### Pacnew and Pacsave

- A `.pacnew` file is created during an upgrade to avoid overwriting the existing configuration file.

- A `.pacsave` file is created during package removal (or an upgrade that first requires removal) and the system indicates that it should also be backed up.

#### Pacdiff and meld

`eos-pacdiff` combines two tools for ease of use. For non-EOS Arch Linux users, both may be used to resolve conflicting configuration files.

- `pacdiff` \- A utility tool that parses which file information should be merged

- `meld` \- A GUI tool that provide more visual context for merging changes lines into a config file

See [Pacnew and Pacsave](https://wiki.archlinux.org/title/Pacman/Pacnew_and_Pacsave) | [Pacdiff (manpage)](https://man.archlinux.org/man/pacdiff.8.en)

---
---

## Update mirrors

- [reflector-simple/eos-rankmirrors](#reflector--simple-eos--rankmirrors)

- [Alternative mirror configurations](#alternative-mirror-configurations)

---

### reflector-simple/eos-rankmirrors

*Every 1-2 months*

**Mirror issues** are caused when the system cannot access or sync with software repositories. The "404 not found" error occurs when trying to download or update packages from **outdated mirrors**.

#### Update Arch mirrors

1. Update Arch mirrors with: `reflector-simple`

2. Running `reflector-simple` on EOS offers GUI functionality with the usual `reflector` process. By default, the system selects the 20 fastest mirrors based on your set location.
<!-- TO INSERT
*Image: Preference menu that displays when using `reflector-simple`*
-->

3. Adjust the settings to your preference, then hit OK to run the process. It is normal to see warnings as `reflector` tests various mirrors for connectivity speed and age.

4. The system will notify you once the new **mirrorlist** has been generated. Save to apply the settings.
<!-- TO INSERT
*Image: New mirrorlist output from `reflector-simple` listing 20 U.S. mirrors ranked by speed*
-->

5. Refresh the system with: `yay -Syyu`

#### Update EOS mirrors

Endeavour OS has its own distro-unique packages that are modified from the original Arch packages. Thus, EOS mirrors are updated with a separate command.

1. Update EOS-specific mirrors by entering: `eos-rankmirrors`

2. The `eos-rankmirrors` process runs entirely in the terminal (no GUI tool). It may take a few minutes for the terminal to display output.

3. It is normal to see warnings as the system tests various mirrors for connectivity and speed.
<!-- TO INSERT
*Image: eos-rankmirrors Terminal output listing timed-out mirrors and the new mirrorlist*
-->

4. The terminal output will display a list of the fastest 20 mirrors, relevant information, and the original mirrorlist.
<!-- TO INSERT
*Image: eos-rankmirrors Terminal output displaying the original mirrorlist prior to the update*
-->

5. To confirm the mirrorlist changes, enter your system's root password to save the configuration.
<!-- TO INSERT
*Image: eos-rankmirrors Terminal output displaying the original mirrorlist prior to the update*
-->

6. If you do not wish to make the mirrorlist changes, stop the terminal process. By default, this shortcut is bound to `Ctrl+C` in the terminal.

7. Refresh the system with: `yay -Syyu`

---

### Alternative mirror configurations

The Arch wiki [page on mirrors](https://wiki.archlinux.org/title/Mirrors) lists popular mirror configuration alternatives for simpler management. When configured properly, some can automate the mirror re-ranking process.

#### Reflector

`reflector` ([wiki](https://wiki.archlinux.org/title/Reflector) | [repo](https://xyne.dev/projects/reflector/) | [AUR](https://archlinux.org/packages/?name=reflector)) provides automation with a systemd service and timer.

1. Retrieves the latest mirrorlist from the [Mirror Status page](https://archlinux.org/mirrors/status/)

2. Filters/ranks the mirrors by speed

3. Then overwrites the current `/etc/pacman.d/mirrorlist`

Use `reflector` to update to the latest 20 mirrors sorted by speed, then save the mirrorlist by entering:
`reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist`

#### Ghostmirror

`ghostmirror` is another alternative mirror configuration software ([wiki](https://wiki.archlinux.org/title/Ghostmirror) | [repo](https://github.com/vbextreme/ghostmirror) | [AUR](https://aur.archlinux.org/packages/ghostmirror/)). If properly configured, `ghostmirror` entirely automates mirror management.

1. Checks that mirrors are **synchronized**

2. Performs **download speed tests** on top of the usual ping test

3. Automates the process via `systemd`

See [Arch mirrors](https://wiki.archlinux.org/title/Mirrors) | [Official mirror status](https://archlinux.org/mirrors/status/) | [Reflector](https://wiki.archlinux.org/title/Reflector) | [Ghostmirror](https://wiki.archlinux.org/title/Ghostmirror)

---
---

## 🗑️ Clear unused files {#clear-unused-files}

- [journalctl -vacuum-time=6weeks](#journalctl)

- [paccache -r](#paccache--r)

- [pacman -Qdtq | pacman -Rns -](#pacman-orphans)

---

### journalctl

*Every 1-2 months*

`systemd` logs system activity in the journal and is used to troubleshoot issues. Open the journal by entering `journalctl` in a terminal.

To maintain a log of the past 6 weeks while clearing excess logs, run:
`journalctl --vacuum-time=6weeks`

It is recommended to keep 4 weeks as a minimum, but the number of weeks can be adjusted to personal preference. By default, the journal can only contain up to 4 GB of information.

See [systemd Journal](https://wiki.archlinux.org/title/Systemd/Journal)

---

### paccache -r  {#paccache}

*Every 1-2 months*

By default, `pacman` keeps 3 versions of package files in the `/var/cache/pacman/pkg` cache.

To clear the cache and maintain the 3 most recent versions, run: `paccache -r`

It is generally **not recommended** to delete all past versions unless disk space is needed. Keeping previous versions may prevents redundant downloads when downgrading or reinstalling.

- To also clear the cache of all versions of uninstalled packages, run: `paccache -ruk0`

- To clear the cache of all uninstalled packages **and** unused `pacman sync` databases, run: `pacman -Sc`

See [Pacman: Cleaning the cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache)

---

### pacman orphans

*Every 1-2 months*

**Orphans** are dependencies that are **no longer needed** by any program. These accumulate when:

- Packages are uninstalled with `pacman -R package-name` instead of **`-Rs`**

- A new package version no longer requires a dependency it originally used/was installed with

This command recursively removes **orphans** (unused packages) along with their configuration files:
`sudo pacman -Qdtq | sudo pacman -Rns -`

<!-- TO INSERT
*Image: Terminal output listing an orphan after running sudo pacman -Qdtq | sudo pacman -Rns -
-->

Enter `Y` to remove the packages listed after running the command.

- Note: If there are orphans listed that you wish to **keep**, specify the orphans to exclude from removal using this command:

`sudo pacman -D --asexplicit package-name`

If the terminal outputs error: argument '-' specified with empty stdin, this means there are **no orphans** to remove.

See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

---
---

# xfce4-screenshooter

- [Cursor selection to clipboard](#cursor-selection-to-clipboard)

- [Auto-save fullscreen screenshot](#auto-save-fullscreen-screenshot)

---

## Cursor selection to clipboard

This function copies a selected area directly to the clipboard without saving a file. In Windows OS, this is the Win+Shift+S shortcut.

1. Open your Keyboard application and its Application Shortcuts tab
<!-- TO INSERT
Image: EOS keyboard application on the application shortcuts tab, with a red box highlighting the Add and Edit options
-->

2. Add a shortcut (or edit an existing one)

3. Enter `xfce4-screenshooter -rc` into the command field
<!-- TO INSERT
EOS keyboard app dialogue window waiting on input for the command field
-->

4. When prompted, enter the shortcut (ex. `Ctrl+Alt+S`) to run `xcfe4-screenshooter -rc`

5. The command and its assigned shortcut will appear in the Application Shortcuts list and can be edited as needed
<!-- TO INSERT
Image: EOS keyboard application on the application shortcuts tab. The "xfce4-screenshooter -rc" command is selected, and a red box highlights the Add, Edit, and Remove options
-->

See [xfce4-screenshooter documentation](https://docs.xfce.org/apps/xfce4-screenshooter/usage) for additional functions.

---

## Auto-save fullscreen screenshot

```
In progress... [----C o  o  o  o  o  o  o ]
```

The command to save a fullscreen screenshot without needing to enter a filename is:

`xfce4-screenshooter -f -s "$HOME/Desktop/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"`

<!--
Progress notes:  However, the command instead saves a file named `$(date +%Y-%m-%d_%H-%M-%S).png`, which means the shell command is not being accepted as one.
-->
---
---

# Other topics

- [git clone to location](#git-clone-to-location)

- [Change login background](#chain-login-background)

- [Nvidia-settings config](#nvidia--settings-config)

---

## git clone to location

By default, repositories are cloned into the current directory (usually `~/home`). You can specify the intended location for a repository using:

`git clone <repository-url> <destination-folder>`

Clone into a **new** directory, use:
- `git clone <https://github.com/myuser/example-repo.git> /desired/directory/path`

Clone into an **existing, empty** directory:
- `git clone <repo-url> /existing/folder`

Clone the contents into the **current**, non-empty directory:
- `git clone <repo-url> .`
- Remember, this command clones the contents into the **current directory**. It is important to cd into the correct directory first, lest files explode everywhere.

---

## Change login background

Background images set in the **Login Window** GUI editor will only display if the system's **display manager** (DM) and/or greeter can access the specified image file.

If the image cannot be accessed, the login screen will display only the background color that was set.

To create access without changing permission settings, you must move the desired background image into the folder that the DM or greeter have access to. These are:

- `/usr/share/endeavouros/backgrounds` for default EOS backgrounds

- `/usr/share/backgrounds/xfce`  for users using the XFCE desktop environment (DE)

Locate the image you would like to use as a background, then follow the steps below:

1. **As root**, move the intended background file into the **display manager**'s background folder:
`sudo pacman mv /your/bg-file.png /usr/share/endeavouros/backgrounds`

2. Then, use sudo nano to edit the **`slick-greeter`** config file. If it doesn't exist, the file will be created:
`sudo nano /etc/lightdm/slick-greeter.conf`

3. Apply the changes in the section with the `[Greeter]` heading
```
[Greeter]
draw-grid=false
background=/usr/share/endeavouros/backgrounds/bg-file.png
```

4. Press `Ctrl+X` to quit, then press `Y` to save the file

5. **Reboot** the computer for the changes to take place

---

## Nvidia-settings config

`In progress... [----C o  o  o  o  o  o  o ]`

<!-- 
Progress notes: Potentially an issue of the Nvidia GPU not properly loading upon boot, which would prevent the nvidia-settings configs from applying.
[eoswiki](https://discovery.endeavouros.com/nvidia/nvidia-optional-enhancements-and-troubleshooting/2021/03/)
[archwiki](https://wiki.archlinux.org/title/NVIDIA#Early_loading)

Need to set up force early load (**dracut**, not mkinitcpio).

-->

- [Nvidia ArchWiki page](https://wiki.archlinux.org/title/NVIDIA#NVIDIA_Settings)

- [Troubleshooting forum](https://forum.endeavouros.com/t/nvidia-settings-isnt-remembering-my-config-changes/3089/6)

---
