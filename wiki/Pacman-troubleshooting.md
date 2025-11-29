# Common Issues
This page overviews common errors that prevent `pacman` from completing a full system upgrade and refresh.

The terminal command `sudo pacman -Syu` is used to update and refresh Arch Linux systems. During the update process, `pacman` may run into issues that prevent it from finishing updates. These errors or warnings are logged in the specific errors in the terminal.

<!-- ### sudo pacman -Syu overview ### -->
<details>
    <summary><span style="color:#7F7FFF;">
    <b>Quick overview of <code>sudo pacman -Syu</code></b>
    </summary>

## Quick overview of `sudo pacman -Syu`
**`pacman`** is the package manager of Arch Linux and is used to install and update packages. To update and refresh the system, open a terminal and enter:
```bash
sudo pacman -Syu
```

1. When prompted with the above command, `pacman` syncs to Arch/EOS package databases and detects whether there are any new versions for installed packages and dependencies.
   
2. The terminal outputs a list of the updateable packages with a comparison of the old and new versions.

3. `pacman` waits for user permission to proceed with the update. If proceeding, user is required to enter the system's root password.

4. After initiating the update, `pacman` downloads new package files, installs them, and deletes old versions.
</details>
<!-- ### end overview ### -->

<!-- ### example pacman -Syu terminal output ### -->
<details> 
    <summary><b><code>sudo pacman -Syu</code> terminal output example:</b></summary>

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
<!-- ### end example terminal output ### -->

---

## Mirror and GPGME errors
**Mirrors** are servers located around the world that store copies of software packages. A **`mirrorlist`** stores information on multiple mirrors, allowing the system to shift between them in case one is outdated or has poor connection.

<details open>
    <summary>Attempting system updates with **out-of-date** or **out-of-sync** mirrors may result in the following errors or warnings:
    </summary>

| Terminal message  | Probable cause         |
|:------------------|:-----------------------|
| `error: GPGME error: No data` | Files from the package database are outdated or corrupt | 
| `error: failed to synchronize all databases (invalid or corrupted database (PGP signature))` | Outdated mirrors - not in sync with package databases |
| `error: failed retrieving file 'package-version.pkg' from arch.mirror.mx : The requested URL returned error: 404` | Mirror cannot be reached, or package files are not available | 
| `error: failed to commit transaction (failed to retrieve some files)` | Mirror cannot be reached, or package files are not available |
| `warning: too many errors from arch.mirror.mx, skipping for the remainder of this transaction` | Slow/unstable mirror connection (timed out) or network issues | 

</details>

<br/>
<details>
    <summary><span style="color:#7F7FFF;">
    <b>Re-rank mirrors to update the <code>mirrorlist</code> with up-to-date/synchronized mirrors</b>
    </summary>

### Re-rank mirrors

1. Update **Arch** mirrors with:

    ```bash
    reflector-simple
    ```
   - In the GUI tool, you can choose mirror preferences, such as location, max amount, and seconds for connection timeout.

2. After saving a new mirrorlist configuration, always **refresh your system** with:

    ```bash
    yay -Syyu
    ```
    
3. Update **EOS** mirrors with:

    ```bash
    eos-rankmirrors
    ```
   - Information displays in the terminal (no GUI tool).

4. Always **refresh your system** with `yay -Syyu` after updating a mirrorlist.

> [!WARNING]
> Persistent issues despite re-reranking mirrors indicate an **outdated system**.
>
> Refer to the detailed guides on [How to update mirrors](./system-maintenance-guide#update-mirrors) and [How to update system](./system-maintenance-guide#update-system)

</details><br/>

---

## `pacdiff` files

During a `sudo pacman -Syu` update, you may receive errors such as:

```bash
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
# or
warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

**Resolve conflicting configuration files** by running:

```bash
eos-pacdiff
```

> [!CAUTION]
> It is highly recommended to resolve the conflicts **ASAP** to prevent further issues. Misconfigured files have the potential to break your system!

> See [System maintenance: **`eos-pacdiff`**](./system-maintenance-guide#eos-pacdiff)

---


> [!TIP] What is GPGME?
> The [GPGME](https://www.gnupg.org/software/gpgme/index.html) library is used to provide applications easier access to GnuPG functions.
> 
>[GnuPG](https://www.gnupg.org/download/index.html) is a command-line interface (CLI) tool. As a **universal crypto engine**, it is often used as the **crypto backend** for many applications.
> - See: [GPGME GitHub mirror](https://github.com/gpg/gpgme), [GnuPG documentation](https://www.gnupg.org/documentation/index.html)
> 

 
[Top of page](#pacman-troubleshooting)
