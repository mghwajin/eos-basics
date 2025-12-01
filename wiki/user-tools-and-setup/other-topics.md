#

```shell
                                    [----c o o o o o o ]
This guide is a work in progress!!  [-----Co o o o o o ]
                                    [------c o o o o o ]
```

---

<!-- TO DO LIST
#########################################
### Autosave fullscreen screenshot

The command to automatically save a fullscreen screenshot without being prompted to enter a filename is:
  ```shell
  xfce4-screenshooter -f -s "$HOME/Desktop/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
  ```

Issue
  However, the command instead saves a file named `$(date +%Y-%m-%d_%H-%M-%S).png`, which means the shell command is not being accepted as one.
---

##########################################
## Nvidia-settings config issues

Issue
  Running nvidia-settings and selecting options does not save and apply the settings to the next login session (even when saving config files as root)
  
  This is potentially an issue of the Nvidia GPU not properly loading upon boot, which would prevent the nvidia-settings configs from applying. 

Solution(?)
  Need to set up force early load (**dracut**, not mkinitcpio).

Resources
  - [eoswiki](https://discovery.endeavouros.com/nvidia/nvidia-optional-enhancements-and-troubleshooting/2021/03/)
  - [archwiki](https://wiki.archlinux.org/title/NVIDIA#Early_loading)
  - [Nvidia ArchWiki page](https://wiki.archlinux.org/title/NVIDIA#NVIDIA_Settings)
  - [Troubleshooting forum](https://forum.endeavouros.com/t/nvidia-settings-isnt-remembering-my-config-changes/3089/6)
--- 
--> 

<!-- EOF -->