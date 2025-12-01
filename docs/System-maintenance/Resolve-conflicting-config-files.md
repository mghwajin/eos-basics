### `eos-pacdiff`

*At system prompt*

The system notifies you whenever it detects **conflicting configuration files**.
  ```shell
  warning: /etc/pacman.d/xyz installed as /etc/pacman.d/xyz.pacnew
  # or
  warning: /etc/pacman.d/abc installed as /etc/pacman.d/abc.pacsave
  ```

**Resolve these ASAP!**

1. When notified by the system about conflicting config files, run:

    ```shell
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
  ```shell
  # do NOT run as root
  DIFFPROG=meld pacdiff -s
  ```

  Here is an example of how a file comparison looks like in **`meld`**:
    ![A side-by-side visual comparison of an example script file in the `meld` GUI from the LinuxOpSys website](https://linuxopsys.com/wp-content/uploads/2024/03/basic_usages_1.png)
    *Image credit: LinuxOpSys article - How to use Meld diff tool in Linux*
  </details> <!-- ##### END ##### -->
<br/>

> See [Pacnew and Pacsave](https://wiki.archlinux.org/title/Pacman/Pacnew_and_Pacsave) | [**`Pacdiff`** (manpage)](https://man.archlinux.org/man/pacdiff.8.en)
