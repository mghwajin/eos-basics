# System maintenance overview
Arch-based distros like EOS have **rolling release** updates to keep up with the latest feature releases. Users should regularly update and run maintenance tasks to keep the system up-to-date.

- Create system backups with Timeshift
- Update system and packages
- Resolve conflicting config files
- Mirror maintenance
- Clean unused system files

For EndeavourOS users who are not comfortable with running terminal commands, 
the [**EOS Welcome App**](https://discovery.endeavouros.com/endeavouros-tools/welcome/2021/03/) Assistant is a helpful alternative to running maintenance tasks. 

![EOS Welcome program v25.10.3-1 with a list of update scripts on the Assistant tab.](./images/eos-welcome.png)

## Maintenance command cheatsheet
Below is a table of the commonly used system update and maintenance commands, as well as how often they should be run.

| Command | Usage | Recommended frequency |
|:--------|:------|:----------------------|
|`sudo timeshift --create` or `--check` | `create` an unscheduled system snapshot, or `check` if one is due before creating  one | Daily, before system changes |
|`sudo pacman -Syu`| Syncs, refreshes, and updates packages to newest versions | Daily |
|`yay` | Updates core system packages | Every 1-2 weeks | 
|`eos-update` | Updates EOS-specific core packages | Every 1-2 weeks | 
|`eos-pacdiff` | Notifies user of any conflicting configs, then calls `pacdiff` and `meld` to assist with merges. Same function as `DIFFPROG=meld pacdiff -s` | At system prompt | 
|`DIFFPROG=meld pacdiff -s` | Uses `pacdiff` tool and `meld` GUI to assist the user with merging config files. Same function as `eos-pacdiff` | At system prompt | 
|`reflector-simple` | Runs `reflector` with a GUI assistant to generate an updated Arch `mirrorlist` | Every 1-2 months | 
|`eos-rankmirrors` | Generates a new EndeavourOS `mirrorlist` ranking the latest 20 mirrors by rate | Every 2-3 months |
|`paccache -r` | Clear `pacman` cache of uninstalled packages, maintaining the last 3 versions | Monthly | 
| | |
| | |

<!-- EOF -->