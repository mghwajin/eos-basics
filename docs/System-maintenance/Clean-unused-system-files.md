<!---------------------------------------->

# Clear unused system files
As `pacman` and `yay` install and update packages, different package versions and dependencies are stored in their respective caches. 

These cached files should periodically be cleared to keep the system's disk space tidy.

- [Clear `systemd` journal](#clear-systemd-journal)
- [Clear `pacman` cache]()
- [Clear `yay` cache]()
- [Remove orphan dependencies]()

<!------------------------------------>

## Clear `pacman` cache
By default, `pacman` keeps 3 versions of package files in the `/var/cache/pacman/pkg` cache.

To clear the cache and maintain the 3 most recent versions, run:

```shell
paccache -r
```

It is generally **not recommended** to delete all past versions unless disk space is really needed. Keeping previous versions may prevent redundant downloads when downgrading or reinstalling packages.

| Terminal command | Description | 
|:-----------------|:------------|
| `paccache -r` | Clears the `/var/cache/pacman/pkg` cache of uninstalled packages while retaining the last 3 versions. |
| `paccache -ruk0` | Clears the `pacman` cache of **all versions** of uninstalled packages.
| `pacman -Sc` | A powerful command. Clears the `pacman` cache of all uninstalled packages and unused `pacman sync` databases. |

> [!NOTE]
> The `pacman` and `yay` caches should be cleared every 1-2 months. 
> 
> See: [Pacman: Cleaning the package cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache)


## Clear `yay` cache
`yay` also maintains a cache of AUR packages.

To clear the `yay` cache, run:
```shell
yay -Sc
```

`yay`` will confirm which files of the cache it should remove. By default, it keeps all locally installed packages. Example output below:

```shell
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
```

<!------------------------------------------>

## Clear `systemd` journal
`systemd` logs system activity in the journal and is used to troubleshoot issues. Open the journal by entering `journalctl` in a terminal.

To maintain a log of the past 6 weeks while clearing excess logs, run:
  ```shell
  journalctl --vacuum-time=6weeks
  ```

It is recommended to **keep 4 weeks of logs at minimum**, but the number of weeks can be adjusted to personal preference. By default, the journal can only contain up to 4 GB of information.

> [!NOTE]
>
> See [`systemd journal`](https://wiki.archlinux.org/title/Systemd/Journal)

<!------------------------------------------>
---

## Remove orphan dependencies

**Orphans** are dependencies that are **no longer needed** by any program. These accumulate on the system when:

- Packages are uninstalled with `pacman -R package-name` instead of **`-Rs`**

- A new package version no longer requires a dependency it originally used/was installed with

---

This command recursively removes **orphans** (unused dependencies) along with their configuration files:

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


> [!NOTE]
> 
> See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

---

<!-- EOF -->