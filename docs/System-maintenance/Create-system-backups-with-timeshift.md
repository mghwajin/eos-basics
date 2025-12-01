# Create system backups with `timeshift`

`sudo timeshift check` or `create`

*Daily*

[**`timeshift`**](https://wiki.archlinux.org/title/Timeshift) creates a snapshot of **system files and settings**. It can be used to restore the system to a prior state if the current state becomes unbootable/unusable.

Create a snapshot **on demand** (unscheduled) by using:

  ```shell
  sudo timeshift --create
  ```

To create a snapshot only if a **scheduled one is due**, use:

  ```shell
  sudo timeshift --check
  ```

> **Important!** \
 It is highly recommended to create **daily** backups and **before attempting system changes**. 

<br/>
<details><br/> <!-- ##### Timeshift screenshot ##### -->
  <summary><b>Example terminal output of <code>timeshift --help</code></b></summary>

  ![Terminal output of Timeshift (v25.07.7) listing its syntax and CLI options](../images/timeshift.png)
</details> <!-- ##### END ##### -->

<details><br/> <!-- ##### Timeshift settings ##### -->
  <summary><b>What settings are available in <code>timeshift</code>?</b></summary>

  **Snapshot type**
  - **RSYNC** snapshots are incremental copies of changed system files, while keeping hard-links for files unchanged from the previous snapshot. These take up more space but are much more simple to set up.
  - **BTRFS** snapshots are only available on systems that are set up with a BTRFS file system. These snapshots are much quicker and space-efficient, but properly configuring these settings requires more technical knowledge of Linux file systems.

  **Back up location**
  - It is recommended to set snapshots to save onto an external drive, or an internal drive separate from the system's boot partition. This eases the process of recovering to a previous state if the current one becomes unbootable.
  -  Note that while the specific drive/device can be selected, `timeshift`'s default directory path on the device **cannot be changed**.
  -  Additionally, BTRFS snapshots can only be saved onto the same device that the system's root partition is located on.

  **Saved data** 
  - To save disk space, `timeshift` does not save any user files by default. Setting `timeshift` to regularly save **non-system files will use a very large amount of disk space**.

  **`cron` scheduler** ([`cronie`](https://archlinux.org/packages/extra/x86_64/cronie/)) 
  -  Users can set up `cron` to schedule time-based jobs. Setting up a timer/scheduler allows the system to automatically take snapshots when due while saving up to the designated number of snapshots per category. 
  - **This requires manual setup. See the "How do I manually enable/disable the `cron/cronie` scheduler" section below.**

  **Snapshot limits** 
  - Once the number of snapshots reaches the set limit, `timeshift` deletes the oldest snapshot of that category. The exact amounts vary between users. Here is an example of snapshot limits:
    - 4 monthly
    - 4 weekly
    - 7 daily
    - 5 hourly
    - 5 boot
</details> <!-- ##### END ##### -->




> See [**`Timeshift`** wiki](https://wiki.archlinux.org/title/Timeshift) | [**`cron`** wiki](https://wiki.archlinux.org/title/Cron#Configuration) | [Restore system with snapshot](https://itsfoss.gitlab.io/post/how-to-use-timeshift-to-backup-and-restore-linux-system/#restoring-your-linux-system-with-timeshift) 