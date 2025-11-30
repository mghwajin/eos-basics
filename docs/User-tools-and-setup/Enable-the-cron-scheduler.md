<!------------------------------------------->

# Enable the `cronie` scheduler
`cronie` is an implementation of `cron`, which is  a scheduling `daemon` that allows the system to automatically run programs and other jobs on a set schedule. 

Notably, setting up `cronie` is important for setting up automatic system backups through `timeshift`. This ensures the system automatically creates snapshots on system boot, every hour, etc.

> [!NOTE] <span>What is the difference between <code>cron</code> and <code>cronie</code>?</span>
> `cron` has several implementations with variations in scheduling and job management.
>
> `cronie` comes with the `anacron` utility enabled by default, which will run backlogged jobs for systems not continuously running (ex. personal computers).
> 
> See [`cron` guide](https://wiki.gentoo.org/wiki/Cron), [`cronie` repository](https://github.com/cronie-crond/cronie/)

<!------------------------------------------->

## Install and set up `cronie`
To install `cronie`, enter this terminal command:
```shell
sudo pacman -S cronie
```

`cronie` is disabled by default and must be manually enabled with:
```shell
sudo systemctl enable cronie.service
```

If scheduled snapshots have been configured in `timeshift`, the `cronie` scheduler will now run regular jobs to automatically create snapshots.

<!------------------------------------------->

## Disable `cronie`
> [!WARNING] <span>Make sure that system <code>daemons</code> <b>are inactive</b> before disabling them.</span>
> `daemons` such as `cronie` are often needed for essential services. Forcibly disabling them while they are still active (and possibly running jobs) may cause the system to become unstable.

  1. Before disabling `cronie`, make sure to stop the process first with:
       ```shell
       systemctl stop cronie.service
       ```

  2. Check that the process is **inactive** by running:
      ```shell
       systemctl status cronie.service
       ```
     
     <details>
      <summary>Terminal output with active process: </summary>

        ```console
        cronie.service - Command Scheduler
          Loaded: loaded (/usr/lib/systemd/system/cronie.service; enabled; preset: disabled)
          Active: active (running) since Day YYYY-MM-DD HH:MM:SS -timezone; 00h 00min ago
        ...
        ```
     </details>

  3. After verifying that `cronie` is **inactive**, enter:
      ```shell
       systemctl disable cronie.service
       ```

<!------------------------------------------->

<!-- EOF -->