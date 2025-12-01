# Create system backups with `timeshift`
`timeshift` is an important utility tool that creates "snapshots" of key system settings and files. 

These snapshots can be used to restore the system to a prior state if the current state becomes unbootable/unusable.

## Create a snapshot


Create a snapshot **on demand** (unscheduled) by using:
  ```shell
  sudo timeshift --create
  ```

To first check if a snapshot is due, then create one if needed, use:
  ```shell
  sudo timeshift --check
  ```

> [!IMPORTANT]
>  It is highly recommended to create **daily backups** and **before attempting system changes**.
>
> You can set up an automated process to take snapshots at scheduled intervals by enabling the `cron` scheduler.
>
> See:[Enable the `cron` scheduler]()

## `timeshift` options

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

**Snapshot limits** 
  - Once the number of snapshots reaches the set limit, `timeshift` deletes the oldest snapshot of that category. The exact amounts vary between users. Here is an example of snapshot limits:
    - 4 monthly
    - 4 weekly
    - 7 daily
    - 5 hourly
    - 5 boot

> [!NOTE]
> See: [`Timeshift` wiki](https://wiki.archlinux.org/title/Timeshift), [Restore system with snapshot](https://itsfoss.gitlab.io/post/how-to-use-timeshift-to-backup-and-restore-linux-system/#restoring-your-linux-system-with-timeshift) 