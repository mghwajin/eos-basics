<!-------------------------------------->

# System updates with `pacman` and `yay`
There are 3 basic commands that EndeavourOS users should regularly run to keep their system up to date.

- [Overview](#overview)
- [`sudo pacman -Syu`](#sudo-pacman--Syu)
- [`yay`](#yay)
- [`eos-update`](#eos-update)
- [FAQs](#faqs)

## `sudo pacman -Syu`
`pacman` is the package manager used to install and update programs in Arch Linux. To perform a **full system update and refresh**, run:
```shell
sudo pacman -Syu
```

> [!IMPORTANT]
> It is recommended to **update your system daily**. This ensures that system packages are up to date, especially if a previous update's issues were fixed or reverted.

<details open> 
    <summary>
    <code>sudo pacman -Syu</code> terminal output example:
    </summary>

 ```shell
 [user@computer ~] $ sudo pacman -Syu
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
                                      # enter Y to confirm the updates
 :: Proceed with installation? [Y/n]   # enter n to cancel the operation  
 ```
 </details>
<br/>

Other basic `pacman` commands include: 
| Command | Description | 
|:--------|:------------|
| `pacman -S <package-name>` | Installs the specific package. |
| `pacman -Rs <package-name>` | Removes a package and its dependencies. Using the `-Rs` option helps to prevent orphan dependencies. |
| `pacman -Ss <package-name>` | Searches for a specified package on the system. |
|`pacman -Qi <package-name>` | Retrieve a list of the dependencies a package needs to run. |

---

> [!NOTE]
> See: [`pacman` (manpage)](https://man.archlinux.org/man/pacman.8), [`pacman` wiki](https://wiki.archlinux.org/title/Pacman)

<!------------------------------------------------------>

## `yay`
[`yay`](https://aur.archlinux.org/packages/yay)<sup>AUR</sup> stands for "yet another yogurt" and it is one of the most popular **AUR helpers** used in Arch Linux community. It simplifies the process of downloading, installing, updating, and removing AUR software.
  
To update the system's native and AUR packages, run:
```shell
yay
```
> [!IMPORTANT]
It is recommended to run `yay` at least **every 1-2 weeks**.

The terminal will list the packages available to upgrade and may ask for the user to select:
  1. Which package provider should be used (where to download files from)
  2. If any packages should be excluded from the upgrade
  3. If the Make dependencies should also be removed
  4. Etc.

<details open> 
    <summary>
    Example terminal output of <code>yay</code> waiting for user selection:
    </summary>
 
 ```shell
 [user@computer ~]$ yay
 [sudo] password for user: 
 :: Synchronizing package databases...
  endeavouros is up to date
  core is up to date
  extra is up to date
  multilib is up to date
 :: Searching AUR for updates...
 :: There are 2 providers available for cargo:
 :: Repository extra
    1) rust 2) rustup 
 
 Enter a number (default=1): 
 ==> 
 ```

 > [!CAUTION] 
 > Do NOT run `yay` with root permissions.
 > 
 > As an AUR helper, `yay` does not require root permissions to manage packages. **This prevents accidental (and potentially fatal) system changes.**
 >  
 > Additionally, AUR packages are community-maintained and **unofficial**. It is highly recommended to check build files  for any malicious code before installation.
 </details>

---

> [!NOTE]
> See: [`yay`](https://aur.archlinux.org/packages/yay)<sup>AUR</sup>, [`yay` commands](https://linuxcommandlibrary.com/man/yay), [Arch User Repository (AUR)](https://aur.archlinux.org/), [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers)



<!----------------------------------------->

## `eos-update`
EndeavourOS provides an optional update script that utilizes `pacman` and `yay` to run basic system updates with additional options.

```shell
eos-update
```

<details> 
  <summary><span>
  Here is a summary provided by running <code>eos-update --help</code> in the terminal:
  </summary>

 ```shell
 eos-update is a package updater for EndeavourOS and Arch.

 eos-update is implemented as a wrapper around commands pacman and optionally yay/paru.
 Essentially runs commands 'pacman -Syu' and optionally 'yay -Sua' or 'paru -Sua'.

 eos-update includes (by default) special help in the following situations:
 - A dangling pacman db lock file (/var/lib/pacman/db.lck).
 - Disk space availability for updates (with a configurable minimum space).
 - Keyring package updating before updating other packages.
 - Running the 'sync' command after update. 

 Optional help: 
 - Can clear package databases in case of constant problems with them.
 - Can reset keyrings in case of constant problems with them.
 - Can check the validity of the locally configured lists of mirrors.
 - Updates AUR packages (with option --helper, see Usage below).
 - Ad hoc check for Nvidia GPU driver vs. kernel updates (non-dkms only).
 ```
  </details>

> [!TIP]
> `eos-update` can be used in place of `yay` or `sudo pacman -Syu`.

User preference for update commands varies greatly. `eos-update` performs the same tasks as `yay` and `pacman -Syu` with an added layer of options.
 
Notably, running `eos-update` may be more helpful for users needing a quick fix to the system, and/or users who do not update the system frequently.

---

## FAQs

### Why am I getting errors when I try to update?
For the purposes of this example guide, the update errors are caused by issues with mirrors and `mirrorlist` configurations. These issues can be fixed by re-ranking mirrors to update the `mirrorlist` configuration.

> [!WARNING]
> Outdated package databases will cause errors when `pacman` tries to retrieve the latest package files. This can be fixed through regular mirror maintenance.
> 
> See: [Mirror maintenance guide](mirror-maintenance-guide)

---

### What does the `-Syu` option mean?
Here are some excerpts from the `pacman` manpage:

| `pacman` option | Description |
|:----------------|:------------|
| `-S, --sync` | Synchronize packages. Packages are installed directly from the remote repositories, including all dependencies required to run the packages. | 
| `-y, --refresh` | Download a fresh copy of the master package databases from the servers. This should typically be used each time you use --sysupgrade or -u. | 
| `-u, --sysupgrade` | Upgrades all packages that are out-of-date. Each currently-installed package will be examined and upgraded if a newer package exists. |

> [!NOTE]
> See: [`pacman` manpage](https://man.archlinux.org/man/pacman.8)

---

### What is the difference between `pacman -Syu` and `pacman -Syyu`?
The `-Syyu` option forces a refresh of all package databases, even if they appear to be up to date. This may sometimes be helpful when switching from broken to working mirrors.

However, it is not necessary to use "double" `pacman` commands in most circumstances. In the interest of keeping mirror bandwidth free for other users, they should only be used when necessary.

> [!NOTE]
> See [Mirrors: force `pacman` to refresh the package lists](https://wiki.archlinux.org/title/Mirrors#Force_pacman_to_refresh_the_package_lists)

---

### What is the AUR?
AUR stands for the *Arch User Repository*, which is a large library of user-produced packages for Arch Linux. You can find many useful tools here that are created and maintained by the Arch community.
  
Popular and well-maintained packages are voted on by the community to include in the official Arch *extra* repository.

---

### How do I download and install AUR packages?

  Downloading and building an AUR package is fairly simple:
  
  1. Clone the `git` repository listed on the package's AUR page:
   
      ```sh
      git clone https://aur.archlinux.org/package-name.git
      ```

  2. Change into the package directory:
   
      ```sh
      cd <package-name>
      ```

  3. Build and install the package with:
      ```sh
      makepkg -si
      # or
      pacman -U package_name-version-1.0.1.pkg.tar.zst
      ```

> [!WARNING] 
> **Always review the installation files (i.e. `PKGBUILD`) for any malicious code.** Good user standing is required to maintain packages on AUR, but is not a foolproof screening method.

<!-- EOF -->