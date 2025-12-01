<!---------------------------------------->

# Clear unused system files
`pacman` and `yay` store different versions of packages and their dependencies in cache folders. Unused files, dependencies, and logs accumulate over time and should periodically be cleared to keep the system's disk space tidy.

- [Clear `pacman` cache](#clear-pacman-cache)
- [Clear `yay` cache](#clear-yay-cache)
- [Clear `systemd` journal](#clear-systemd-journal)
- [Remove orphan dependencies](#remove-orphan-dependencies)

---

## Clear `pacman` cache
By default, `pacman` stores package files in the `/var/cache/pacman/pkg` cache. This is a system-wide cache that can be accessed by helpers such as `yay`.

The `paccache` utility tool is used to remove old packages from the `pacman` cache while retaining the 3 most recent versions:
```shell
paccache -r
```

It is generally **not recommended** to delete all past versions unless disk space is really needed. Keeping previous versions may prevent redundant downloads when downgrading or reinstalling packages.

| Terminal command | Description | 
|:-----------------|:------------|
| `paccache -r` | Clears the `/var/cache/pacman/pkg` cache of all packages while retaining the last 3 versions. |
| `paccache -ru` | Clears the `pacman` cache of **uninstalled** packages while retaining the last 3 versions. | 
| `paccache -ruk0` | Clears the `pacman` cache of all versions of **uninstalled** packages.
| `pacman -Sc` | Clears the `pacman` cache of all uninstalled packages and unused `pacman sync` databases. This isn't recommended for network-shared caches. |

> [!IMPORTANT]
>
> It is recommended to clear the `pacman` and `yay` caches **every 1-2 months**. 
> 
> See: [`paccache` (manpage)](https://man.archlinux.org/man/paccache.8), [Pacman: Cleaning the package cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache)


## Clear `yay` cache
`yay` maintains a separate user-specific cache for AUR packages and their build files. 

Use this command to clear all cached AUR packages and untracked files:
```shell
yay -Sc
```

`yay` will confirm which files of the cache it should remove. By default, it keeps all locally installed packages. `yay -Sc` is considered an extended `pacman` command and can also clear the `pacman` cache at the same time.

<details open>
  <summary>Example <code>yay -Sc</code> output below: </summary>

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
</details>

> [!NOTE]
> See: [`yay` commands](https://linuxcommandlibrary.com/man/yay)


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
> See: [`systemd journal`](https://wiki.archlinux.org/title/Systemd/Journal)

<!------------------------------------------>

## Remove orphan dependencies

**Orphans** are dependencies that are **no longer needed** by any program. These accumulate on the system when:

- Packages are uninstalled with `pacman -R <package-name>` instead of the more thorough `-Rs` option.

- A new package version no longer requires a dependency it originally used or was installed with.

This combined command will list orphans (unused package dependencies). After user confirmation, and recursively removes them along with their configuration files:
```shell
sudo pacman -Qdtq | sudo pacman -Rns -
```

After running `sudo pacman -Qdtq | sudo pacman -Rns -`, enter `Y` to confirm removal of the listed orphans.

  ![Terminal output listing an orphan after running `sudo pacman -Qdtq | sudo pacman -Rns -`](./images/remove-orphans.png)

---

> [!TIP]
> If the terminal outputs `error: argument '-' specified with empty stdin`, this means there are **no orphans** to remove.

If there are orphan dependencies that you wish to **keep**, specify beforehand which ones should be excluded from removal with this command:
```shell
sudo pacman -D --asexplicit <package-name>
```


| Terminal command | Description | 
|:-----------------|:------------|
| `sudo pacman -Qdtq` | Lists all orphan dependencies. This is useful for checking if there are any orphans that should be kept. |
| `sudo pacman -Rns <package-name>` | Removes a specified orphan. |
| `sudo pacman -D --asexplicit <package-name>` | Excludes the specific orphan from removal.

> [!NOTE]
> 
> See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

<!-- EOF -->