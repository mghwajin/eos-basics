# Clear unused system files

- [`journalctl --vacuum-time=6weeks`](#journalctl) \- clear journal logs
- [`paccache -r`](#paccache--r) \- clear package cache
- [`sudo pacman -Qdtq | sudo pacman -Rns -`](#pacman-orphans) \- remove orphans

---

## `journalctl`

*Every 1-2 months*

**`systemd`** logs system activity in the journal and is used to troubleshoot issues. Open the journal by entering `journalctl` in a terminal.

To maintain a log of the past 6 weeks while clearing excess logs, run:
  ```shell
  journalctl --vacuum-time=6weeks
  ```

It is recommended to keep 4 weeks as a minimum, but the number of weeks can be adjusted to personal preference. By default, the journal can only contain up to 4 GB of information.

> See [**`systemd journal`**](https://wiki.archlinux.org/title/Systemd/Journal)

---

## `paccache -r`

`yay -Yc` 

```shell
[kain@malice ~]$ yay -Sc
[sudo] password for kain: 
Packages to keep:
  All locally installed packages

Cache directory: /var/cache/pacman/pkg/
:: Do you want to remove all other packages from cache? [Y/n] y
removing old packages from cache...

Database directory: /var/lib/pacman/
:: Do you want to remove unused repositories? [Y/n] y
removing unused sync repositories...

Build directory: /home/kain/.cache/yay
:: Do you want to remove all other AUR packages from cache? [Y/n] y
removing AUR packages from cache...
:: Do you want to remove ALL untracked AUR files? [Y/n] y
removing untracked AUR files from cache...
Removing gtk-engine-murrine-0.98.2-5-x86_64.pkg.tar.zst
Removing gtk2-engines-murrine_0.98.2-4.debian.tar.xz
Removing murrine-0.98.2.tar.xz
Removing code-1.106.3-url-handler.desktop.in
Removing code-1.106.3-workspace.xml.in
Removing code-1.106.3.desktop.in
Removing code_x64_1.106.3.tar.gz
Removing visual-studio-code-bin-1.106.3-1-x86_64.pkg.tar.zst


```

*Every 1-2 months*

By default, `pacman` keeps 3 versions of package files in the `/var/cache/pacman/pkg` cache.

To clear the cache and maintain the 3 most recent versions, run:

```shell
paccache -r
```

It is generally **not recommended** to delete all past versions unless disk space is really needed. Keeping previous versions may prevent redundant downloads when downgrading or reinstalling packages.

- To clear the cache of **all versions** of uninstalled packages, run:

  ```shell
  paccache -ruk0
  ```

- To clear the cache of all uninstalled packages **and** unused `pacman sync` databases, run:

  ```shell
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

```shell
sudo pacman -Qdtq | sudo pacman -Rns -
```
- If there are orphans listed that you wish to **keep**, specify the orphans to exclude from removal using this command:
  ```shell
  sudo pacman -D --asexplicit package-name
  ```

- Enter `Y` to remove the packages listed after running the command.
  
  ![Terminal output listing an orphan after running `sudo pacman -Qdtq | sudo pacman -Rns -`](../images/remove-orphans.png)

If the terminal outputs `error: argument '-' specified with empty stdin`, this means there are **no orphans** to remove.

> See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

[Top of page](#system-maintenance-guide)

---