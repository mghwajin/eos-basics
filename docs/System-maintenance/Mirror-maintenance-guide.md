# Mirror maintenance guide
This is a beginner's guide that overviews the definitions of mirrors and `mirrorlists`, possible errors, and how to maintain up-to-date mirrors.

- [Overview](#overview)
- [Re-rank mirrors](#re-rank-mirrors)
- [Common issues: outdated mirrors](#common-issues-outdated-mirrors)
- [FAQs](#faqs)
- 
<!---------------------------------------------------------->

## Overview
**Mirrors** are servers located around the world that store copies of software packages. When upgrading packages, your EndeavourOS system utilizes multiple mirrors, which are noted in a `mirrorlist`. 

A well-maintained `mirrorlist` ensures that the `pacman` package manager can access the most up-to-date package files when performing system updates. 

To update a `mirrorlist` configuration, users should run commands to **re-rank mirrors**.

> [!IMPORTANT] <span>Keep a regular update schedule!</span>
> As a general rule, mirrors should be re-ranked **every 1-2 months**.
> 
> Outdated mirrors can prevent `pacman` from updating applications, including the system's **core packages**.

<!---------------------------------------------------------->

## Re-rank mirrors
`mirrorlists` are configured separately for **Arch** mirrors and **EndeavourOS** mirrors. The process is the same, but different commands are used.

### Re-rank Arch mirrors
> [!NOTE] <span>Re-rank Arch mirrors at least <b>every 1-2 months.</b></span>
> Arch packages are updated on a frequent and unscheduled rolling-release basis. Your Arch `mirrorlist` configuration should be updated regularly so your system can access up-to-date package databases.

1. Update the Arch `mirrorlist` by running the command:
    ```shell
    reflector-simple
    ```

2. By default, `reflector-simple` selects the **20 fastest** mirrors based on your set location. You can adjust these preferences in the GUI tool.
 
    ![A GUI Preference menu that displays after running `reflector-simple`, displaying settings such as region, filter by options, and amount.](../images/reflector-simple-1.png)

   - The `reflector-simple` GUI tool allows easy customization of mirror regions, amount, and ranking priority (latest, fastest, etc.)

3. Hit **OK** to confirm the selection and run the process. It is normal to see warnings as `reflector` tests various mirrors for connectivity speed and age.

4. The system will notify you once the new Arch `mirrorlist` has been generated. **Save** to apply the configuration changes.
   
   ![New mirrorlist output from `reflector-simple` listing 20 U.S. mirrors ranked by speed.](../images/reflector-simple-2.png)

5. **Refresh the system** to sync the newly obtained mirrors with the Arch package databases:
    ```shell
    yay -Syyu
    ```
---

> [!CAUTION] <span>Do NOT run <code>yay</code> with root permissions.</span>
> As an AUR helper, `yay` does not require root permissions to manage packages. This prevents accidental (and potentially fatal) system changes.
> 
> AUR packages are community-maintained and **unofficial**, and may potentially contain malicious code despite preventative measures.

---

### Re-rank EndeavourOS mirrors
**EndeavourOS** has its own **distro-unique packages** (modified versions or additional) that are distinct from Arch packages. These are stored in EOS-specific mirrors.

> [!NOTE] <span>Re-rank EOS mirrors at least <b>every 2-3 months.</b></span>
> 
> EndeavourOS mirrors are updated less frequently than Arch mirrors. As long as you maintain a regular update schedule, the EOS `mirrorlist` typically does not require monthly updates.

1. Update the EndeavourOS ` mirrorlist` by entering:
    ```shell
    eos-rankmirrors
    ```

2. The `eos-rankmirrors` process only shows terminal output (no GUI tool).

3. The terminal may display errors/warnings as the system tests various mirrors for connectivity and speed. It may take a few minutes to find the requisite amount of mirrors.
   
   ![`eos-rankmirrors` terminal output listing timed-out mirrors and the new mirrorlist.](../images/eos-rankmirrors-1.png)

4. By default, the `eos-rankmirrors` script generates a new `mirrorlist` containing the 20 fastest EOS mirrors. These are listed along with the original `mirrorlist`.

5. To confirm and save the changes, enter your system's root password.
   
   ![Bottom of `eos-rankmirrors` terminal output waiting for root password confirmation to save the mirrorlist.](../images/eos-rankmirrors-3.png)

6. If you do **NOT** wish to make the  `mirrorlist` changes, stop the terminal process. By default, this shortcut is bound to `Ctrl+C` in the terminal.

7. After confirming any mirrorlist changes, refresh the system with:
    ```shell
    yay -Syyu
    ```


> [!CAUTION] <span>Do NOT run <code>yay</code> with root permissions.</span>
> As an AUR helper, `yay` does not require root permissions to manage packages. This prevents accidental (and potentially fatal) system changes.
> 
> AUR packages are community-maintained and **unofficial**, and may potentially contain malicious code despite preventative measures.

---

<!---------------------------------------------------------->

## Common issues: outdated mirrors
When `pacman` receives a command to update packages and refresh the system, it attempts to connect to package databases. Outdated mirrors can prevent `pacman` from updating your system to the newest packages. 

Common error or warning messages include:

| Terminal message  | Issue         |
|:------------------|:--------------|
| `error: GPGME error: No data` | Files from the package database are outdated or corrupt | 
| `error: failed to synchronize all databases (invalid or corrupted database (PGP signature))` | Outdated mirrors - not in sync with package databases |
| `error: failed retrieving file 'package-version.pkg' from arch.mirror.mx : The requested URL returned error: 404` | Mirror cannot be reached, or package files are not available | 
| `error: failed to commit transaction (failed to retrieve some files)` | Mirror cannot be reached, or package files are not available |
| `warning: too many errors from arch.mirror.mx, skipping for the remainder of this transaction` | Slow/unstable mirror connection (timed out) or network issues | 

If `pacman` runs into these errors during a system update, **be sure to [re-rank the mirrors](#re-rank-mirrors)**.

> [!WARNING]
> If these errors/warnings persist despite re-reranking mirrors, this indicates **outdated core system packages**. Core packages can be updated by running [System update commands]().

---

<!---------------------------------------------------------->

## FAQs
Useful links:
- [Arch wiki: Mirrors](https://wiki.archlinux.org/title/Mirrors)
- [Official Arch mirror status](https://archlinux.org/mirrors/status/)
- `reflector`<sup>[AUR](https://archlinux.org/packages/?name=reflector)</sup> | [`reflector` wiki](https://wiki.archlinux.org/title/Reflector)
- `ghostmirror`<sup>[AUR](https://aur.archlinux.org/packages/ghostmirror/)</sup> | [`ghostmirror` wiki](https://wiki.archlinux.org/title/Ghostmirror) 

---

<!-- TOC ignore:true -->
### How does running `sudo pacman -Syu` use mirrors?
When the user enters `sudo pacman -Syu` into a terminal, the `pacman` package manager begins the process to **sync** (`-S`), refresh (`-y`), and update (`-u`) the system.

  1. `pacman` attempts to connect and sync to Arch and EOS package databases.
   
  2. If succesful, `pacman` searches for and detects new versions of packages/dependencies that are installed on your system.
   
  3. The terminal outputs a list of the updateable packages with a comparison of the old and new versions.
   
  4. `pacman` waits for user permission to proceed with the update. If proceeding, user is required to enter the system's root password.
   
  5. After initiating the package(s) update, `pacman` retrieves new package files from the mirror.
   
  6. If `pacman` successfully retrieves package files, it installs them then deletes old versions.

---

<!-- TOC ignore:true -->
### What is GPGME?
 **GnuPG** and **GPGME** are two tools are used to safely encrypt/decrypt the package files that `pacman` retrieves from package databases. If mirrors cannot access package databases (or are out of sync), you may see `GPGME` or `PGP` related errors.
- The [GPGME](https://www.gnupg.org/software/gpgme/index.html) library is used to provide applications easier access to GnuPG functions.

- [GnuPG](https://www.gnupg.org/documentation/index.html) is a command-line interface (CLI) tool. As a **universal crypto engine**, it is often used as the **crypto backend** for many applications.

---

<!-- TOC ignore:true -->
### How do I use `reflector` instead of `reflector-simple`?
EOS uses uses `reflector` as its default mirror management program.`reflector-simple` provides a GUI tool, but it is possible to use specific CLI commands and options for the same result.
  
To update to and save the **latest 20 mirrors** sorted by **speed**, enter:
```shell
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
```

  This process will:
   1. Retrieve the latest mirrorlist from the [Arch mirror status page](https://archlinux.org/mirrors/status/).

   2. Filter/rank the mirrors by speed (until it has found 20, or the listed amount).

   3. Then overwrite the current `/etc/pacman.d/mirrorlist` config file

> [!TIP]
> Refer to the [`reflector` manpage](https://man.archlinux.org/man/reflector.1) documentation for detailed usage. 
>
> This information can also be accessed offline by running `reflector --help` in the terminal.

---

<!-- TOC ignore:true -->
### Are there mirror management alternatives?
Popular alternatives to mirror management are listed on the Arch [mirrors wiki](https://wiki.archlinux.org/title/Mirrors). Some programs can automate mirror management when configured properly.

One such example is `ghostmirror`, which:
   1. Checks that mirrors are **synchronized**
   
   2. Performs **download speed tests** on top of the usual ping test
   
   3. Automates the process via `systemd`

---

<!-- EOF -->
