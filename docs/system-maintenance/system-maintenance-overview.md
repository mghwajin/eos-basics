<!------------------------------------->

# System maintenance overview
Arch-based distros like EOS have **rolling release** updates to keep up with the latest feature releases. Users should regularly run maintenance tasks to keep the system clean and up to date.

- [Clean unused system files](clean-unused-system-files)
- [Create system backups with `timeshift`](create-system-backups-with-timeshift)
- [System updates with `pacman` and `yay`](system-updates-with-pacman-and-yay)
- [Mirror maintenance guide](mirror-maintenance-guide)
- [Resolve conflicting config files](resolve-conflicting-config-files)

<!--------------------------------------------->

## Maintenance cheatsheet
Below is a quick reference table of common maintenance commands and the recommended usage frequency.

| Command | Usage | Recommended frequency |
|:--------|:------|:----------------------|
|`sudo timeshift --create` or `--check` | `create` an unscheduled system snapshot, or `check` first and generate one if a scheduled snapshot is due | Daily, before making system changes |
|`sudo pacman -Syu`| Syncs, refreshes, and updates packages to newest versions | Daily |
| `sudo pacman -Rns <package>` or `yay -Rns <package>` | Uninstalls and removes a package and its dependencies | As needed | 
|`yay` | Updates core system packages. Can also run `eos-update --aur` | Every 1-2 weeks | 
|`eos-update` | Updates EOS-specific core packages | Every 1-2 weeks | 
|`eos-pacdiff` | Notifies user of any conflicting configs, then calls `pacdiff` and `meld` to assist with merges. Same function as `DIFFPROG=meld pacdiff -s` | At system prompt | 
|`DIFFPROG=meld pacdiff -s` | Uses `pacdiff` tool and `meld` GUI to assist the user with merging config files. Same function as `eos-pacdiff` | At system prompt | 
|`reflector-simple` | Runs `reflector` with a GUI assistant to generate an updated Arch `mirrorlist` | Every 1-2 months | 
|`eos-rankmirrors` | Generates a new EndeavourOS `mirrorlist` ranking the latest 20 mirrors by rate | Every 2-3 months |
|`paccache -r` | Clear `pacman` cache of uninstalled packages, maintaining the last 3 versions | Every 1-2 months | 
| `yay -Sc` | Clear the `yay` cache | As needed |
|`journalctl --vacuum-time=6weeks` | Clear the `systemd` journal and retain logs for the past 6 weeks | Every 1-2 months
|`sudo pacman -Qdtq \| sudo pacman -Rns -` | Lists orphaned dependencies (`pacman -Qqtd`), then removes with user confirmation (`sudo pacman -Rns -`) | Every 1-2 months |

---

> [!TIP] 
> For users unfamiliar with terminal usage or needing quick system fixes, the [**EOS Welcome App**](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) Assistant is a helpful alternative to running maintenance tasks.

Open the **Welcome App** from System Applications, or with the `eos-welcome` terminal command.

![EOS Welcome program v25.10.3-1 with a list of update scripts on the Assistant tab.](./images/eos-welcome.png)

<!-- EOF -->