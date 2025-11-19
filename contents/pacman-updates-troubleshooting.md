
# Pacman updates troubleshooting

**`pacman`** is the package manager of Arch Linux and is used to install and update programs.

While `sudo pacman -Syu` performs a full system update and refresh, it may error out or only partially complete the update process. 

- [GPGME error: No data / failed to synchronize all databases](#gpgme-error-no-data)

  - [Remove and refresh `pacman sync` file](#remove-and-refresh-pacman-sync-file)
  
  - [GPGME and GnuPG](#gpgme-and-gnupg)

- [Mirrorlist errors and warnings](#mirrorlist-errors-and-warnings)

  - [Re-rank mirrors](#re-rank-mirrors)

- [Installed as .pacnew or .pacsave](#installed-as-pacnew-or-pacsave)

---

## GPGME error: No data

After attempting an update with `sudo pacman -Syu`, the terminal may output errors such as:

```bash
error: GPGME error: No data
  // or
error: failed to synchronize all databases (invalid or corrupted database (PGP signature))
```

These errors indicate that there is either an issue with the database itself, or that the system was unable to verify encryption keys of the package database.

**Remove and refresh the `pacman sync` file** to fix this issue.

### Remove and refresh pacman sync file

1. Open a terminal and remove the `pacman sync` file by entering:

    ```bash
    sudo rm -R /var/lib/pacman/sync
    ```

2. Refresh the local cache (i.e. rebuild the deleted file) with:

    ```bash
    sudo pacman -Syy
    ```

3. Lastly, reattempt the update:

    ```bash
    sudo pacman -Syu
    ```

---

### GPGME and GnuPG

**GPGME** and **GnuPG** are used to securely encrypt/decrypt data that the `pacman` installer pulls from the package databases.

- The [GPGME](https://www.gnupg.org/software/gpgme/index.html) library is used to provide applications easier access to GnuPG functions.

- [GnuPG](https://www.gnupg.org/download/index.html) is a command-line interface (CLI) tool. As a **universal crypto engine**, it is often used as the **crypto backend** for many applications.

---

## Mirrorlist errors and warnings

**Mirrors** are servers located around the world that store copies of Linux distro software. A wide spread of **mirrors** helps to minimize any interruptions to services, as the system will utilize multiple while upgrading packages. 

The list of mirrors and their information is stored in a **mirrorlist**.

During a `sudo pacman -Syu` update, the terminal may output **mirrorlist** errors or warnings.

```bash
error: failed retrieving file 'wine-10.17-1-x86\_64.pkg.tar.zst' from arch.jsc.mx : The requested URL returned error: 404
  // or
warning: too many errors from arch.jsc.mx, skipping for the remainder of this transaction
```

These issues are usually caused by **outdated** mirrors and/or **slow connections**.

**Re-rank** the mirrors to prioritize mirrors that were recently-updated and have faster connection.

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

For a more detailed guide, see [System maintenance: Update mirrors](../contents/system-maintenance.md#update-mirrors).

Persistent issues despite re-reranking mirrors indicate an **outdated system**.  See [System maintenance: Update system](../contents/system-maintenance.md#update-system) to review how to keep your system up-to-date.

---

## Installed as .pacnew or .pacsave

During a `sudo pacman -Syu` update, you may receive errors such as:

```bash
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
  // or
warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

**Resolve conflicting configuration files** by running:

```bash
eos-pacdiff
```

It is highly recommended to resolve the conflicts ASAP to prevent further issues. Misconfigured files have the potential to break your system!

See [System maintenance: eos-pacdiff](../contents/system-maintenance.md#eos-pacdiff)

[Back to top](#pacman-updates-troubleshooting) | [README](../README.md)
