<details><br/> <!-- ##### cron scheduler setup ##### -->
  <summary><b>How do I manually enable/disable the <code>cron/cronie</code> scheduler?</b></summary>

  System processes (`daemons`) like `cron`/`cronie` are often needed for essential services on the system. These should **INACTIVE** before you disable them, otherwise the system may become unstable.

  Some `daemons` come disabled by default and must be **manually enabled**.
  
  To enable the scheduling service, run:
  ```bash
  sudo systemctl enable cronie.service
  ```
  To **disable** the scheduler, there are a few steps involved:
  ```bash
  # Stop the service
  systemctl stop cronie.service

  # Verify that the process is inactive
  systemctl status cronie.service

  # If the process is *INACTIVE*, set to disable on boot
  systemctl disable cronie.service
  ```
  
  > See [daemon (manpage)](https://man.archlinux.org/man/daemon.7.en)
  </details> <!-- ##### END ###### -->
  <br/> 

> See [**`Timeshift`** wiki](https://wiki.archlinux.org/title/Timeshift) | [**`cron`** wiki](https://wiki.archlinux.org/title/Cron#Configuration) | [Restore system with snapshot](https://itsfoss.gitlab.io/post/how-to-use-timeshift-to-backup-and-restore-linux-system/#restoring-your-linux-system-with-timeshift) 