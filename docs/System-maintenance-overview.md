# System maintenance overview

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
>
> - [EOS Welcome App](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) \- This handy app guides you through the installation process and can quickly run useful maintenance operations.

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

<!------------------------------------------------------>
<br/>
<details><br/> 
  <summary><b>What does the <code>-Syu</code>mean?</b></summary>

  Here are some helpful excerpts from the [`pacman` manpage](https://man.archlinux.org/man/pacman.8) defining each operation:
  ```bash
  -S, --sync        # Synchronize packages. Packages are installed directly from the remote
                    # repositories, including all dependencies required to run the packages.

  -y, --refresh     # Download a fresh copy of the master package databases from the servers.
                    # This should typically be used each time you use --sysupgrade or -u.

  -u, --sysupgrade  # Upgrades all packages that are out-of-date. Each currently-installed
                    # package will be examined and upgraded if a newer package exists.
  ```
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### pacman -Syyu comparison ##### -->
  <summary><b>What's the difference between <code>pacman -Syu</code> and <code>pacman -Syyu</code>?</b></summary>

  The `-Syyu` option forces a refresh of all package databases, even if they appear to be up to date. This may sometimes be helpful when switching from broken to working mirrors.

  However, it is not necessary to use "double" `pacman` commands in most circumstances. In the interest of keeping mirror bandwidth free for other users, they should only be used when necessary.

  > See [Mirrors: force `pacman` to refresh the package lists](https://wiki.archlinux.org/title/Mirrors#Force_pacman_to_refresh_the_package_lists)
</details> 

<!------------------------------------------------------>

<details> 
    <summary>
    <b><code>sudo pacman -Syu</code> terminal output example</b>
    </summary>

```bash
[user@home ~] $ sudo pacman -Syu
[sudo password for user]:

:: Synchronizing package databases...
endeavouros                 17.0 KiB  3.17 KiB/s 00:05 [--------------------] 100%
core                       117.4 KiB  23.3 KiB/s 00:05 [--------------------] 100%
extra                        8.0 MiB  1447 KiB/s 00:06 [--------------------] 100%
multilib                   125.4 KiB   416 KiB/s 00:00 [--------------------] 100%
: Starting full system upgrade...
resolving dependencies...
looking for conflicting packages...

Package (2)                 Old Version  New Version  Net Change  Download Size

endeavouros/package-1       25.11-1      25.11.1-1      0.00 MiB       0.02 MiB
endeavouros/package-2       12.5.2-2     12.5.3-1       0.02 MiB       3.20 MiB

Total Download Size:   3.21 MiB
Total Installed Size:  9.42 MiB
Net Upgrade Size:      0.02 MiB

:: Proceed with installation? [Y/n]
```
</details>
<br/>

<!------------------------------------------------------>

> [!NOTE]
> See [`pacman` (manpage)](https://man.archlinux.org/man/pacman.8) | [`pacman` wiki](https://wiki.archlinux.org/title/Pacman)

---

### `yay`

*Weekly*

Update the system's native and Arch User Repository (AUR) packages with one of the following commands:

  ```bash
  yay  # or
  eos-update --aur
  ```

> **Important Note!!** \
> The `yay` update command **SHOULD NOT** be run as the root user (i.e. `sudo`). Building packages as `root` via the `makepkg` command is already disallowed, and is additionally considered unsafe and risky. 
> 
> Allowing `root` to run commands all throughout your system **can seriously mess with important configurations and break your system**.
>
> When in doubt, always verify whether running a command as `sudo` is safe!

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

  - `pacdiff` \- A utility tool that allows users to view and merge any changes between the original and `.pacnew/.pacsave` files.

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

<!-- EOF -->