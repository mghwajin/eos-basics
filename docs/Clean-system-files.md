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

> See [Pacman Tips and Tricks: Orphans](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_\(orphans\))

[Top of page](#system-maintenance-guide)

---