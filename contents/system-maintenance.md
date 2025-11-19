
# System maintenance

To keep your EOS system healthy and up-to-date, it is recommended to regularly run system maintenance commands. A quick overview of maintenance tasks and commands is provided below.

- [Create system backups](#create-system-backups)

  - [`sudo timeshift --check`/`--create`](#sudo-timeshift-check-or-create) \- backup system settings
  
- [Update system](#update-system)

  - [`sudo pacman -Syu`](#sudo-pacman--syu) \- update and refresh system
  
  - [`yay`](#yay) \- update core packages
  
  - [`eos-pacdiff`](#eos-pacdiff) \- resolve conflicting configs
  
- [Update mirrors](#update-mirrors)

  - [`reflector-simple`](#reflector-simple) \- Arch mirrors

  - [`eos-rankmirrors`](#eos-rankmirrors) \- EOS mirrors
  
- [Clean unused files](#clean-unused-files)

  - [`journalctl --vacuum-time=6weeks`](#journalctl) \- clear journal logs
  
  - [`paccache -r`](#paccache--r) \- clear package cache
  
  - [`sudo pacman -Qdtq | sudo pacman -Rns -`](#pacman-orphans) \- remove orphans :'\(

These maintenance tasks are run from the **command-line interface** (CLI) and will back up system data, update programs, clean unused files, and more. The **EOS Welcome App** also comes with an assistant to help users easily run key maintenance scripts.

![EOS Welcome program v25.10.3-1 with a list of update scripts on the Assistant tab.](../eos-basics-images/eos-welcome.png)

---

## Create system backups

### sudo timeshift check or create

*Daily*

[**`timeshift`**](https://wiki.archlinux.org/title/Timeshift) creates a snapshot of **system files and settings**. It can be used to restore the system to a prior state if the current state becomes unbootable/unusable.

To save disk space, timeshift does not save any user files unless specifically directed to do so. Setting Timeshift to regularly save **non-system files will use a very large amount of disk space**.

Create a snapshot on demand (unscheduled) by using:

```bash
sudo timeshift --create
```

To create a snapshot only if a scheduled one is due, use:

```bash
sudo timeshift --check
```

**! ----- IMPORTANT ----- !**
In addition to daily backups, **it is highly recommended to backup before attempting to make any significant changes to the system.**

It is also helpful to save the backups to an external drive (or an internal drive that is separate from the root). This eases the process of recovering a previous state when the current one is unbootable.

![Terminal output of Timeshift (v25.07.7) listing its syntax and CLI options](../eos-basics-images/timeshift.png)

---

### Current Timeshift settings

- **RSYNC snapshots** \- Creates copies of system files and hard-links unchanged files from the previous snapshot

- **Back up location** \- Saves to external /dev/nvme0n1p1 to allow for restore even if system disk is damaged. This is done via a liveboot system and restoring a selected snapshot

- **Saved data** \- Files/directories excluded to save disk space

- **`cron` scheduler** ([`cronie`](https://archlinux.org/packages/extra/x86_64/cronie/)) \- Automatically takes snapshots when due, saving up to the designated number of snapshots per category.

  - The scheduling daemon must be **manually enabled** by running:

    ```bash
    sudo systemctl enable cronie.service
    ```

- **Snapshot limits** \- Once the number of snapshots reaches the set limit, timeshift deletes the oldest snapshot in the list. Current limits set to:
  - 4 monthly
  - 4 weekly
  - 7 daily
  - 5 hourly
  - 5 boot

#### Disable cronie.service

To disable the `cron` scheduler process, follow the steps below:

1. Stop the system daemon by entering:

    ```bash
    systemctl stop cronie.service
    ```

2. Verify that the process is inactive with:

    ```bash
    systemctl status cronie.service
    ```
  
  ![Terminal output after running `systemctl status cronie.service` showing the daemon's active status.](../eos-basics-images/systemctl-status-cronie.png)
  
3. Then disable the **inactive** process from starting on boot:

    ```bash
    systemctl disable cronie.service
    ```

**Note**: System processes (daemons) are often needed for essential services on the system. These should only be disabled when they are **inactive**, otherwise the computer system may become very unstable and not function properly.
  
See [**`Timeshift`**](https://wiki.archlinux.org/title/Timeshift) | [**`cron`**](https://wiki.archlinux.org/title/Cron#Configuration) | [daemon (manpage)](https://man.archlinux.org/man/daemon.7.en)

---

## Update system

- [`sudo pacman -Syu`](#sudo-pacman--syu) \- update and refresh system
  
- [`yay`](#yay) \- update core packages

  - [What is `yay`?](#what-is-yay)

  - [Which update command should I run?](#which-update-command-should-i-run)
  
- [`eos-pacdiff`](#eos-pacdiff) \- resolve conflicting configs

  - [Pacnew and pacsave](#pacnew-and-pacsave)

  - [Pacdiff and meld](#pacdiff-and-meld)

---

### sudo pacman -Syu

*Daily*

**`pacman`** is the package manager used to install and update programs in Arch Linux.

`sudo pacman -Syu` performs a **full system update and refresh**. It is recommended to run this daily, though user preference will vary.

![A Terminal running `sudo pacman -Syu` waiting for user confirmation (Y/n) to proceed with installation.](../eos-basics-images/sudo-pacman--syu.png)

Other basic `pacman` commands include:

- `pacman -S package-name` \-  install specific package

- `pacman -Rs package-name` \- removes package and its unused dependencies

- `pacman -Syy` \- sync local database with online repositories before upgrading packages

- `pacman -Syyu` \- sync repositories and update system simultaneously

See [**`pacman`**](https://wiki.archlinux.org/title/Pacman)

---

### yay

*Weekly*

Update the system's native and AUR packages (Arch User Repository) with one of the following:

```bash
yay
```

or

```bash
eos-update --aur
```

---

#### What is yay?

[**`yay`**](https://aur.archlinux.org/packages/yay)<sup>AUR</sup> stands for "yet another yogurt" and it is one of the most popular **AUR helpers**.

**AUR helpers** simplify the process of downloading, installing, updating, and removing AUR software.

---

#### Which update command should I run?

This is up to personal preference. The most beginner-friendly option is `eos-update --aur` or `eos-update`. Some members of the EOS community also recommend using `eos-update` for a quick fix to the system.

Others prefer to run `yay` since it does all that is required without the additional script processes used in `eos-update --aur`.

See [**`yay`**](https://aur.archlinux.org/packages/yay)<sup>AUR</sup>| [Arch User Repository (AUR)](https://aur.archlinux.org/) | [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers)

---

### eos-pacdiff

*At system prompt*

The system notifies you whenever it detects **conflicting configuration files**.

```bash
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
  // or
warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

These conflicts are generated when `pacman` creates copies of config files and prevents overwrite by appending `.pacsave` or `.pacnew` to the filename.

**Resolve these conflicts ASAP!!** 

Conflicting config files may prevent a program from functioning properly, or altogether, and will only get messier the longer they remain unfixed.

1. When notified by the system about conflicting config files, run:

    ```bash
    eos-pacdiff
    ```

2. Select `V(iew)` to compare the config files side-by-side

3. Review the files for significant changes.

4. `R(emove), `O(verwrite)`, or `M(erge)` the differing lines as necessary.

**! ----- IMPORTANT ----- !**
**Always review files carefully before merging config files. Incorrect configurations may break your system.**

Refrain from modifying key system files such as `/etc/passwd`, `/etc/group`, and `/etc/shadow` unless you know what you're doing, otherwise you **may lock yourself out of your system.**

---

#### Pacnew and Pacsave

- A `.pacnew` file is created during an upgrade to avoid overwriting the existing configuration file.

- A `.pacsave` file is created during package removal (or an upgrade that first requires removal) and the system indicates that it should also be backed up.

---

#### Pacdiff and meld

`eos-pacdiff` combines two tools for ease of use. For non-EOS Arch Linux users, both are run to resolve conflicting configuration files.

- `pacdiff` \- A utility tool that parses which file information should be merged

- `meld` \- A GUI tool that provide more visual context for merging changes lines into a config file

See [Pacnew and Pacsave](https://wiki.archlinux.org/title/Pacman/Pacnew_and_Pacsave) | [Pacdiff (manpage)](https://man.archlinux.org/man/pacdiff.8.en)

---

## Update mirrors

*Every 1-2 months*

**Mirror issues** are caused when the system cannot access or sync with software repositories, or if the connection is too slow. The "404 not found" error occurs when trying to download or update packages from **outdated mirrors**.

- [`reflector-simple`](#reflector-simple) \- Arch mirrors

- [`eos-rankmirrors`](#eos-rankmirrors) \- EOS mirrors

- [Alternative mirror configurations](#alternative-mirror-configurations)

---

### reflector-simple

`Reflector-simple` is a quick custom script that updates Arch mirrors with a GUI tool.

1. Update Arch mirrors by running the command:

    ```bash
    reflector-simple
    ```

2. By default, `reflector-simple` selects the 20 fastest mirrors based on your set location. You can adjust these preferences in the GUI tool.

![A GUI Preference menu that displays after running `reflector-simple`, displaying options such as region, filter by, and amount.](../eos-basics-images/reflector-simple-1.png)

3. Hit OK to confirm the selection and run the process. It is normal to see warnings as `reflector` tests various mirrors for connectivity speed and age.

4. The system will notify you once the new **mirrorlist** has been generated. Save to apply the configuration changes.

![New mirrorlist output from `reflector-simple` listing 20 U.S. mirrors ranked by speed.](../eos-basics-images/reflector-simple-2.png)

5. Refresh the system with:

    ```bash
    yay -Syyu
    ```

---

### eos-rankmirrors

Endeavour OS has its own distro-unique packages that are modified from the original Arch packages. Thus, EOS mirrors are updated with a separate command.

1. Update EOS mirrors from the terminal by entering:

    ```bash
    eos-rankmirrors
    ```

2. The `eos-rankmirrors` process does not have a GUI tool and will only display output in the terminal.

3. It is normal to see various warnings as the system tests various mirrors for connectivity and speed. It may take a few minutes before the output shows.

![`eos-rankmirrors` terminal output listing timed-out mirrors and the new mirrorlist.](../eos-basics-images/eos-rankmirrors-1.png)

4. The terminal output will display a list of the fastest 20 mirrors, relevant information, and the original mirrorlist.

![Continuation of `eos-rankmirrors` terminal output displaying the original mirrorlist prior to the update.](../eos-basics-images/eos-rankmirrors-2.png)

5. To confirm the mirrorlist changes, enter your system's root password to save the configuration.

![Bottom of `eos-rankmirrors` terminal output waiting for root password confirmation to save the mirrorlist.](../eos-basics-images/eos-rankmirrors-3.png)

6. If you do not wish to make the mirrorlist changes, stop the terminal process. By default, this shortcut is bound to `Ctrl+C` in the terminal.

7. After confirming any mirrorlist changes, refresh the system with:

    ```bash
    yay -Syyu
    ```

---

### Alternative mirror configurations

The Arch wiki [page on mirrors](https://wiki.archlinux.org/title/Mirrors) lists popular mirror configuration alternatives for simpler management. When configured properly, some can automate the mirror re-ranking process.

By default, EOS uses `reflector` as its mirror management program. Specific CLI commands can be used instead of the `reflector-simple` script if desired.

#### Reflector

**`reflector`**<sup>[AUR](https://archlinux.org/packages/?name=reflector)</sup> ([wiki](https://wiki.archlinux.org/title/Reflector) | [repo](https://xyne.dev/projects/reflector/)) provides automation with a `systemd` service and timer. Running the program will:

1. Retrieve the latest mirrorlist from the [Mirror Status page](https://archlinux.org/mirrors/status/)

2. Filter/rank the mirrors by speed

3. Then overwrite the current `/etc/pacman.d/mirrorlist` config file

To update to and save the **latest 20 mirrors** sorted by **speed**, enter:

```bash
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
```

---

#### Ghostmirror

`ghostmirror`<sup>[AUR](https://aur.archlinux.org/packages/ghostmirror/)</sup> ([wiki](https://wiki.archlinux.org/title/Ghostmirror) | [repo](https://github.com/vbextreme/ghostmirro)) is another mirror management software which can automate the process with proper configuration.

1. Checks that mirrors are **synchronized**

2. Performs **download speed tests** on top of the usual ping test

3. Automates the process via `systemd`

See [Arch mirrors](https://wiki.archlinux.org/title/Mirrors) | [Official mirror status](https://archlinux.org/mirrors/status/) | [**`reflector`**](https://wiki.archlinux.org/title/Reflector) | [**`Ghostmirror`**](https://wiki.archlinux.org/title/Ghostmirror)

---

## Clear unused files

- [`journalctl --vacuum-time=6weeks`](#journalctl) \- clear journal logs
  
- [`paccache -r`](#paccache--r) \- clear package cache
  
- [`sudo pacman -Qdtq | sudo pacman -Rns -`](#pacman-orphans) \- remove orphans :'\(

---

### journalctl

*Every 1-2 months*

**`systemd`** logs system activity in the journal and is used to troubleshoot issues. Open the journal by entering `journalctl` in a terminal.

To maintain a log of the past 6 weeks while clearing excess logs, run:

```bash
journalctl --vacuum-time=6weeks
```

It is recommended to keep 4 weeks as a minimum, but the number of weeks can be adjusted to personal preference. By default, the journal can only contain up to 4 GB of information.

See [**`systemd journal`**](https://wiki.archlinux.org/title/Systemd/Journal)

---

### paccache -r

*Every 1-2 months*

By default, `pacman` keeps 3 versions of package files in the `/var/cache/pacman/pkg` cache.

To clear the cache and maintain the 3 most recent versions, run:

```bash
paccache -r
```

It is generally **not recommended** to delete all past versions unless disk space is really needed. Keeping previous versions may prevent redundant downloads when downgrading or reinstalling packages.

- To clear the cache of **all versions** of uninstalled packages, run:

  ```bash
  paccache -ruk0
  ```

- To clear the cache of all uninstalled packages **and** unused `pacman sync` databases, run:

  ```bash
  pacman -Sc
  ```

See [Pacman: Cleaning the package cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache)

---

### pacman orphans

*Every 1-2 months*

**Orphans** are dependencies that are **no longer needed** by any program. These accumulate on the system when:

- Packages are uninstalled with `pacman -R package-name` instead of **`-Rs`**

- A new package version no longer requires a dependency it originally used/was installed with

This command recursively removes **orphans** (unused packages) along with their configuration files:

```bash
sudo pacman -Qdtq | sudo pacman -Rns -
```
- Enter `Y` to remove the packages listed after running the command.

- If the terminal outputs `error: argument '-' specified with empty stdin`, this means there are **no orphans** to remove.

![Terminal output listing an orphan after running `sudo pacman -Qdtq | sudo pacman -Rns -`](../eos-basics-images/remove-orphans.png)

**Note**: If there are orphans listed that you wish to **keep**, specify the orphans to exclude from removal using this command:

```bash
sudo pacman -D --asexplicit package-name
```

See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

[Back to top](#system-maintenance) | [Back to README](../README.md)

---