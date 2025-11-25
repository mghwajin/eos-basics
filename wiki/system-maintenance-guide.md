# System maintenance guide

Arch-based distro like EOS have **rolling release** updates to keep up with the latest feature releases. Users should regularly update and run maintenance tasks to keep the system healthy and up-to-date.

Here is an overview of update and maintenance command prompts:

- [Create system backups](#create-system-backups)
  - [`sudo timeshift --check`/`--create`](#sudo-timeshift-check-or-create) \- back up system settings
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
  - [`sudo pacman -Qdtq | sudo pacman -Rns -`](#pacman-orphans) \- remove orphans \:\'\(

These maintenance tasks are run in the **command-line interface** (CLI) and will back up system data, update programs, clean unused files, and more. 

Alternatively, the [**EOS Welcome App**](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) Assistant can help users easily run maintenance scripts\. 

![EOS Welcome program v25.10.3-1 with a list of update scripts on the Assistant tab.](./images/eos-welcome.png)

> See [EOS Welcome App](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) 

---

## Create system backups

### `sudo timeshift check` or `create`

*Daily*

[**`timeshift`**](https://wiki.archlinux.org/title/Timeshift) creates a snapshot of **system files and settings**. It can be used to restore the system to a prior state if the current state becomes unbootable/unusable.

Create a snapshot **on demand** (unscheduled) by using:

  ```bash
  sudo timeshift --create
  ```

To create a snapshot only if a **scheduled one is due**, use:

  ```bash
  sudo timeshift --check
  ```

> **Important!** \
 It is highly recommended to create **daily** backups and **before attempting system changes**. 

<br/>
<details><br/> <!-- ##### Timeshift screenshot ##### -->
  <summary><b>Example terminal output of <code>timeshift --help</code></b></summary>

  ![Terminal output of Timeshift (v25.07.7) listing its syntax and CLI options](./images/timeshift.png)
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### Timeshift settings ##### -->
  <summary><b>What settings are available in <code>timeshift</code>?</b></summary>

  **Snapshot type**
  - **RSYNC** snapshots are incremental copies of changed system files, while keeping hard-links for files unchanged from the previous snapshot. These take up more space but are much more simple to set up.
  - **BTRFS** snapshots are only available on systems that are set up with a BTRFS file system. These snapshots are much quicker and space-efficient, but requires more technical knowledge for proper configuration.

  **Back up location**
  - It is recommended to set snapshots to save onto an external drive, or an internal drive separate from the system's boot partition. This eases the process of recovering to a previous state if the current one becomes unbootable.
  -  Note that while the specific drive/device can be selected, `timeshift`'s default directory path on the device **cannot be changed**.

  **Saved data** 
  - To save disk space, `timeshift` does not save any user files by default. Setting `timeshift` to regularly save **non-system files will use a very large amount of disk space**.

  **`cron` scheduler** ([`cronie`](https://archlinux.org/packages/extra/x86_64/cronie/)) 
  -  Users can set up `cron` for to schedule time-based jobs. Setting up a timer/scheduler allows the system to automatically take snapshots when due while saving up to the designated number of snapshots per category. 
  - **This requires manual setup. See below.**

  **Snapshot limits** 
  - Once the number of snapshots reaches the set limit, `timeshift` deletes the oldest snapshot of that category. The exact amounts vary between users. Here is an example of snapshot limits:
    - 4 monthly
    - 4 weekly
    - 7 daily
    - 5 hourly
    - 5 boot
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### cron scheduler setup ##### -->
  <summary><b>How do I manually enable/disable the <code>cron/cronie</code> scheduler?</b></summary>

  System processes (`daemons`) like `cron`/`cronie` are often needed for essential services on the system. These should **INACTIVE** before you disable them, otherwise the system may become unstable.

  Some `daemons` come disabled by default and must be **manually enabled**.
  
  To enable the scheduling service, run:
  ```bash
  sudo systemctl enable cronie.service
  ```
  To **disable** the scheduler, there are a few steps involved:
  ```bash
  # Stop the service
  systemctl stop cronie.service

  # Verify that the process is inactive
  systemctl status cronie.service

  # If the process is *INACTIVE*, set to disable on boot
  systemctl disable cronie.service
  ```
  
  > See [daemon (manpage)](https://man.archlinux.org/man/daemon.7.en)
  </details> <!-- ##### END ###### -->
  <br/> 

> See [**`Timeshift`** wiki](https://wiki.archlinux.org/title/Timeshift) | [**`cron`** wiki](https://wiki.archlinux.org/title/Cron#Configuration) | [Restore system with snapshot](https://itsfoss.gitlab.io/post/how-to-use-timeshift-to-backup-and-restore-linux-system/#restoring-your-linux-system-with-timeshift) 

---

## Update system

- [`sudo pacman -Syu`](#sudo-pacman--syu) \- update and refresh system
- [`yay`](#yay) \- update core packages
- [`eos-pacdiff`](#eos-pacdiff) \- resolve conflicting configs

---

### `sudo pacman -Syu`

*Daily*

**`pacman`** is the package manager used to install and update programs in Arch Linux.

**`sudo pacman -Syu`** performs a **full system update and refresh**. It is recommended to run this daily, though user preference will vary.

![A Terminal running `sudo pacman -Syu` waiting for user confirmation (Y/n) to proceed with installation.](./images/sudo-pacman--syu.png)

Other basic `pacman` commands include: 

- `pacman -S <package-name>` \-  install a specified package
- `pacman -Rs <package-name>` \- removes package and its unused dependencies
- `pacman -Ss <package-name>` \- search for a package
- `pacman -Qi <package-name>` \- retrieve a dependencies list for a package

<br/>
<details><br/> <!--###### pacman -Syu options ##### --> 
  <summary><b>What does the <code>-Syu</code>mean?</b></summary>

  Here are some helpful excerpts from the [`pacman` manpage](https://man.archlinux.org/man/pacman.8) defining each operation:
  ```bash
  -S, --sync        # Synchronize packages. Packages are installed directly from the remote repositories, including all dependencies requires to run the packages.

  -y, --refresh     # Download a fresh copy of the master package databases from the servers. This should typically be used each time you use --sysupgrade or -u.

  -u, --sysupgrade  # Upgrades all packages that are out-of-date. Each currently-installed package will be examined and upgraded if a newer package exists.
  ```
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### pacman -Syyu comparison ##### -->
  <summary><b>What's the difference between <code>pacman -Syu</code> and <code>pacman -Syyu</code>?</b></summary>

  The `-Syyu` option forces a refresh of all package databases, even if they appear to be up to date. This may sometimes be helpful when switching from broken to working mirrors.

  However, it is not necessary to use "double" `pacman` commands in most circumstances. In the interest of keeping mirror bandwidth free for other users, they should only be used when necessary.

  > See [Mirrors: force `pacman` to refresh the package lists](https://wiki.archlinux.org/title/Mirrors#Force_pacman_to_refresh_the_package_lists)
</details> <!-- #####  END #####-->
<br/> 

> See [**`pacman`** (manpage)](https://man.archlinux.org/man/pacman.8) | [`pacman` wiki](https://wiki.archlinux.org/title/Pacman)

---

### `yay`

*Weekly*

Update the system's native and Arch User Repository (AUR) packages with one of the following commands:

  ```bash
  yay  # or
  eos-update --aur
  ```

<br/>
<details><br/> <!-- ##### What is yay? ##### -->
  <summary><b>What is <code>yay</code>?</b></summary>

  [**`yay`**](https://aur.archlinux.org/packages/yay)<sup>AUR</sup> stands for "yet another yogurt" and it is one of the most popular **AUR helpers**.

  **AUR helpers** simplify the process of downloading, installing, updating, and removing AUR software.
</details> <!-- ##### END #####-->

<details> <!-- ##### Should I use yay or eos-update --aur? ##### -->
  <summary><b>Should I use <code>yay</code> or <code>eos-update --aur</code>?</b></summary><br/>

  This is up to user preference. 

  Beginner-friendly options include using `eos-update --aur`, `eos-update`, or the **EOS Welcome Assistant**. Some members of the EOS community also recommend using `eos-update` for a quick fix to the system.

  Others prefer to run `yay` since it does all that is required without the additional script processes used in `eos-update --aur`.
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### What is AUR? ##### -->
  <summary><b>What is the AUR?</b></summary>
  
  AUR stands for the *Arch User Repository*, which is a large library of user-produced packages for Arch Linux. You can find many useful tools here that are created and maintained by the Arch community.
  
  Popular and well-maintained packages are voted on by the community to include in the official Arch *extra* repository.

  Downloading and building an AUR package is fairly simple:
  
  1. Clone the `git` repository listed on the package's AUR page:
   
      ```bash
      git clone https://aur.archlinux.org/package-name.git
      ```

  2. Change into the package directory:
   
      ```bash
      cd <package-name>
      ```

  3. **Always review the installation files (i.e. `PKGBUILD`) for any malicious commands!!** Good standing is required for users publishing packages to AUR, but this is not a foolproof screening method.

  4. Build and install the package with:
      ```bash
      makepkg -si
      # or
      pacman -U package_name-version-1.0.1.pkg.tar.zst
      ```

  > See [Arch User Repository (AUR) homepage](https://aur.archlinux.org/) | [AUR packages](https://aur.archlinux.org/packages) | [AUR wiki](https://wiki.archlinux.org/title/Arch_User_Repository)

</details> <!-- ##### END ##### -->
<br/>

> See [**`yay`**](https://aur.archlinux.org/packages/yay)<sup>AUR</sup>| [Arch User Repository (AUR)](https://aur.archlinux.org/) | [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers)

---

### `eos-pacdiff`

*At system prompt*

The system notifies you whenever it detects **conflicting configuration files**.
  ```bash
  warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
  # or
  warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
  ```

**Resolve these ASAP!**

1. When notified by the system about conflicting config files, run:

    ```bash
    eos-pacdiff
    ```

2. Select `V(iew)` to compare the config files side-by-side.

3. Review the files for significant changes.

4. `R(emove)`, `O(verwrite)`, or `M(erge)` the differing lines as necessary.

> **Always review changes carefully!** \
> Misconfigured config files can prevent programs from functioning properly. It is good practice to create backups of both the original and modified `.pacnew/.pacsave` file. 
> 
> Refrain from modifying key system files such as `/etc/passwd`, `/etc/group`, and `/etc/shadow`, otherwise you **may lock yourself out of your system.**

<details><br/> <!-- ##### Pacnew and pacsave ##### -->
  <summary><b>What are <code>.pacnew</code> and <code>.pacsave</code> files?</b></summary>

These conflicts are generated when `pacman` creates copies of config files and prevents overwrite by appending `.pacsave` or `.pacnew` to the filename.

  - A `.pacnew` file is created during an upgrade to avoid overwriting the existing configuration file.

  - A `.pacsave` file is created during package removal (or an upgrade that first requires removal) and the system indicates that it should also be backed up.
</details> <!-- ##### END ##### -->

<details><br/>
  <summary><b>How does <code>eos-pacdiff</code> work?</b></summary>

  `eos-pacdiff` creates backups for all modes, warns the user not to make rash changes, and calls the below tools to assist the user resolve conflicts:

  - `pacdiff` \- A utility tool that  allows users to view and merge any changes between the original and `.pacnew/.pacsave` files.

  - `meld` \- A GUI tool that helps users view the comparisons between config files

  To run the process manually, run:
  ```bash
  # do NOT run as root
  DIFFPROG=meld pacdiff -s
  ```

  Here is an example of how a file comparison looks like in **`meld`**:
    ![A side-by-side visual comparison of an example script file in the `meld` GUI from the LinuxOpSys website](https://linuxopsys.com/wp-content/uploads/2024/03/basic_usages_1.png)
    *Image credit: LinuxOpSys article - How to use Meld diff tool in Linux*
  </details> <!-- ##### END ##### -->
<br/>

> See [Pacnew and Pacsave](https://wiki.archlinux.org/title/Pacman/Pacnew_and_Pacsave) | [**`Pacdiff`** (manpage)](https://man.archlinux.org/man/pacdiff.8.en)

---

## Update mirrors

*Every 1-2 months*

**Mirror issues** are caused when the system cannot access or sync with software repositories, or if the connection is too slow. The "404 not found" error occurs when trying to download or update packages from **outdated mirrors**.

- [`reflector-simple`](#reflector-simple) \- Arch mirrors
- [`eos-rankmirrors`](#eos-rankmirrors) \- EOS mirrors
- [Alternative mirror configurations](#alternative-mirror-configurations)

---

### `reflector-simple`

`Reflector-simple` is a quick custom script that updates Arch mirrors with a GUI tool.

1. Update Arch mirrors by running the command:

    ```bash
    reflector-simple
    ```

2. By default, `reflector-simple` selects the 20 fastest mirrors based on your set location. You can adjust these preferences in the GUI tool.
 
    ![A GUI Preference menu that displays after running `reflector-simple`, displaying options such as region, filter by, and amount.](./images/reflector-simple-1.png)

3. Hit OK to confirm the selection and run the process. It is normal to see warnings as `reflector` tests various mirrors for connectivity speed and age.

4. The system will notify you once the new **mirrorlist** has been generated. Save to apply the configuration changes.
   
   ![New mirrorlist output from `reflector-simple` listing 20 U.S. mirrors ranked by speed.](./images/reflector-simple-2.png)

5. Refresh the system with:

    ```bash
    yay -Syyu
    # or
    pacman -Syyu
    ```

---

### `eos-rankmirrors`

Endeavour OS has its own distro-unique packages that are modified from the original Arch packages. Thus, EOS mirrors are updated with a separate command.

1. Update EOS mirrors from the terminal by entering:

    ```bash
    eos-rankmirrors
    ```

2. The `eos-rankmirrors` process does not have a GUI tool and will only display output in the terminal.

3. It is normal to see various warnings as the system tests various mirrors for connectivity and speed. It may take a few minutes before the output shows.
   
   ![`eos-rankmirrors` terminal output listing timed-out mirrors and the new mirrorlist.](./images/eos-rankmirrors-1.png)

4. By default, the terminal will display a list of the fastest 20 mirrors, relevant information, and the original mirrorlist.

5. To confirm and save the mirrorlist changes, enter your system's root password.
   
   ![Bottom of `eos-rankmirrors` terminal output waiting for root password confirmation to save the mirrorlist.](./images/eos-rankmirrors-3.png)

6. If you do not wish to make the mirrorlist changes, stop the terminal process. By default, this shortcut is bound to `Ctrl+C` in the terminal.

7. After confirming any mirrorlist changes, refresh the system with:

    ```bash
    yay -Syyu
    # or
    pacman -Syyu
    ```

<br/>
<details><br/> <!-- ##### Is there other mirror management software? ##### -->
  <summary><b>How do I use <code>reflector</code> instead of <code>reflector-simple</code>?</b></summary>

  By default, EOS uses `reflector` as its mirror management program. Specific CLI commands can be used instead of the `reflector-simple` script if desired.
  
  - To update to and save the **latest 20 mirrors** sorted by **speed**, enter:

      ```bash
      reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
      ```

  This process will:
   1. Retrieve the latest mirrorlist from the [Mirror Status page](https://archlinux.org/mirrors/status/)

   2. Filter/rank the mirrors by speed (until it has found 20)

   3. Then overwrite the current `/etc/pacman.d/mirrorlist` config file

</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### Alternatives for mirror management? ##### -->
  <summary><b>What alternatives are there for mirror management?</b></summary>

  Popular alternatives to mirror management are listed on the Arch [mirrors wiki](https://wiki.archlinux.org/title/Mirrors). Some programs can automate mirror management when configured properly.

  One such example is **`ghostmirror`**, which:
  1. Checks that mirrors are **synchronized**
   
  2. Performs **download speed tests** on top of the usual ping test
   
  3. Automates the process via `systemd`
   
  > See `ghostmirror`<sup>[AUR](https://aur.archlinux.org/packages/ghostmirror/)</sup> | [wiki](https://wiki.archlinux.org/title/Ghostmirror) | [repo](https://github.com/vbextreme/ghostmirror)
</details> <!-- ##### END ##### -->
<br/>

> See [Mirrors wiki](https://wiki.archlinux.org/title/Mirrors) | [Official Arch mirror status](https://archlinux.org/mirrors/status/) |  **`reflector`**<sup>[AUR](https://archlinux.org/packages/?name=reflector)</sup> and [wiki](https://wiki.archlinux.org/title/Reflector)

---

## Clear unused files

- [`journalctl --vacuum-time=6weeks`](#journalctl) \- clear journal logs
- [`paccache -r`](#paccache--r) \- clear package cache
- [`sudo pacman -Qdtq | sudo pacman -Rns -`](#pacman-orphans) \- remove orphans

---

### `journalctl`

*Every 1-2 months*

**`systemd`** logs system activity in the journal and is used to troubleshoot issues. Open the journal by entering `journalctl` in a terminal.

To maintain a log of the past 6 weeks while clearing excess logs, run:
  ```bash
  journalctl --vacuum-time=6weeks
  ```

It is recommended to keep 4 weeks as a minimum, but the number of weeks can be adjusted to personal preference. By default, the journal can only contain up to 4 GB of information.

> See [**`systemd journal`**](https://wiki.archlinux.org/title/Systemd/Journal)

---

### `paccache -r`

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

> See [Pacman: Cleaning the package cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache)

---

### `pacman` orphans

*Every 1-2 months*

**Orphans** are dependencies that are **no longer needed** by any program. These accumulate on the system when:

- Packages are uninstalled with `pacman -R package-name` instead of **`-Rs`**

- A new package version no longer requires a dependency it originally used/was installed with

---

This command recursively removes **orphans** (unused packages) along with their configuration files:

```bash
sudo pacman -Qdtq | sudo pacman -Rns -
```
- If there are orphans listed that you wish to **keep**, specify the orphans to exclude from removal using this command:
  ```bash
  sudo pacman -D --asexplicit package-name
  ```

- Enter `Y` to remove the packages listed after running the command.
  
  ![Terminal output listing an orphan after running `sudo pacman -Qdtq | sudo pacman -Rns -`](./images/remove-orphans.png)

If the terminal outputs `error: argument '-' specified with empty stdin`, this means there are **no orphans** to remove.

> See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))\
>  [Top of page](#system-maintenance-guide) | [Back to README](../README.md)

---
<!-- EOF -->