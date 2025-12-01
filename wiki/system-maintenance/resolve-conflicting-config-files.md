<!------------------------------------->

# Resolve conflicting config files
During or after an system update with `sudo pacman -Syu`, the system may notify you of conflicting configuration files.

```shell
warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew

warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
```

The `eos-pacdiff` script is used to resolve these conflicting files. It utilizes both the `pacdiff` utility and `meld` GUI tools.

> [!WARNING]
> **It is highly recommended to resolve these ASAP**.
> 
> Misconfigured or conflicting files **may prevent programs from functioning properly** (or alltogether). Conflicts may also worsen if left unaddressed!

<!------------------------------------------------->

## `eos-pacdiff`
1. When notified by the system about conflicting config files, run:

    ```shell
    eos-pacdiff
    ```

2. Select `V(iew)` to compare the config files side-by-side.

3. Review the files for significant changes.

4. `R(emove)`, `O(verwrite)`, or `M(erge)` the differing lines as necessary.

> [!TIP]
> It is good practice to create backups of both the original and modified `.pacnew/.pacsave` files.

<!-------------------------------------->

## FAQs

### How does `eos-pacdiff` work?
`eos-pacdiff` creates backups for all modes, warns the user not to make rash changes, and calls the below tools to assist the user resolve conflicts:

- `pacdiff` \- A utility tool that allows users to view and merge any changes between the original and `.pacnew/.pacsave` files.

 - `meld` \- A GUI tool that helps users view the comparisons between config files

To run the process manually, use:
```shell
DIFFPROG=meld pacdiff -s
```

---

> [!CAUTION]
> **Do NOT run this with root permissions!**  This is a powerful tool that can cause serious damage to system files if used incorrectly. 
> 
> Refrain from modifying key system files such as `/etc/passwd`, `/etc/group`, and `/etc/shadow`, otherwise you **may lock yourself out of your system.**

Here is an example of how a file comparison looks like in **`meld`**:
  ![A side-by-side visual comparison of an example script file in the `meld` GUI from the LinuxOpSys website](https://linuxopsys.com/wp-content/uploads/2024/03/basic_usages_1.png)
  *Image credit: [LinuxOpSys article - How to use Meld diff tool in Linux]((https://linuxopsys.com/wp-content/uploads/2024/03/basic_usages_1.png))*

> [!NOTE]
>  See: [`Pacdiff` (manpage)](https://man.archlinux.org/man/pacdiff.8.en)

---

### What are `.pacnew` and `.pacsave` files?
These are configuration files that are generated when `pacman` creates copies of config files and prevents overwrite by appending `.pacsave` or `.pacnew` to the filename.

  - A `.pacnew` file is created during an upgrade to avoid overwriting the existing configuration file.

  - A `.pacsave` file is created during package removal (or an upgrade that first requires removal) and the system indicates that it should also be backed up.

> [!NOTE]
>  See: [Pacnew and Pacsave](https://wiki.archlinux.org/title/Pacman/Pacnew_and_Pacsave)

<!-- EOF -->
