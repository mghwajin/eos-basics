# Other topics

- [`git clone` to location](#git-clone-to-location)
- [Change login background](#change-login-background)
- [`xfce4-screenshooter`](#xfce4-screenshooter)
<!-- TO DO: - [`Nvidia-settings` config issues](#nvidia-settings-config-issues) -->

---

## `git clone` to location

By default, **`git`** repositories are cloned into the **current** directory (usually `~/home`). You can specify the intended location for a repository using:

```bash
git clone <repository-url> <destination-folder>
```

- Clone into a **new** directory:

  ```bash
  git clone <https://github.com/myuser/example-repo.git> /desired/directory/path
  ```

- Clone into an **existing, empty** directory:

  ```bash
  git clone <repo-url> /existing/folder
  ```

- Clone the contents into the **current**, non-empty directory:

  ```bash
  git clone <repo-url> .
  ```
  - Remember, this command clones the repository **contents** into the **current directory**. It is important to `cd` to the appropriate working directory first, lest files explode everywhere.

> See [**`git`**](https://git-scm.com/about) | [**`git`** documentation](https://git-scm.com/docs/git) | [**`cd`** (manpage)](https://man.archlinux.org/man/cd.n)

---

## Change login background

Background images set in the **Login Window** GUI editor will only display if the system's **`display manager`** (DM) and/or **`greeter`** can access the specified image file.

![Login Window GUI editor on the Appearance options tab, which contains options for General, Background, Themes, and Optional pictures selections.](./images/login-window-gui.png)

If the image cannot be accessed, the login screen will display only the background color that was set.

By default, the DM and `greeter` can access:

- `/usr/share/endeavouros/backgrounds` \- for default EOS backgrounds

- `/usr/share/backgrounds/xfce` \- for users using the XFCE desktop environment (DE)

---

To create access without changing permission settings, move the desired image into the appropriate backgrounds folder.

1. **As root**, move the intended background file into the display manager's background folder:

    ```bash
    sudo pacman mv /your/bg-file.png /usr/share/endeavouros/backgrounds
    ```

2. Then, use `sudo nano` to edit the `slick-greeter` config file. If this file doesn't exist, a new one will be created:

    ```bash
    sudo nano /etc/lightdm/slick-greeter.conf
    ```

3. Apply the changes in the section with the `[Greeter]` heading.

    ```bash
    [Greeter]
    draw-grid=false
    background=/usr/share/endeavouros/backgrounds/bg-file.png
    ```

4. Press `Ctrl+X` to quit, then press `Y` to save the file.

5. **Reboot the computer** for the changes to take place.

---

## `xfce4-screenshooter`

The XFCE Desktop Environment (DE) comes with `xfce4-screenshooter` screenshot utility tool. This is an alternative to `screengrab` or other adjacent screenshotting tools.

Specific options can be combined to user needs.

- [Cursor selection to clipboard](#cursor-selection-to-clipboard)
<!-- TO DO - [Auto-save fullscreen screenshot](#autosave-fullscreen-screenshot)-->

### Cursor selection to clipboard

You can set up a keyboard shortcut that copies a selected area to the clipboard without saving a file. In Windows OS, this is the `Win+Shift+S` shortcut.

1. Open the **Application Shortcuts** tab in your Keyboard application.
    
    ![EOS keyboard application on the shortcuts tab, with a red box highlighting the Add and Edit options/](./images/xfce-shortcut-1.png)

2. Click on the **Add** or **Edit** button to add/edit a shortcut.

3. Enter the following script into the command field:

    ```bash
    xfce4-screenshooter -rc
    ```

    ![EOS keyboard app dialogue window waiting to record keyboard input for the command field.](./images/xfce-shortcut-2.png)

4. When prompted, enter the shortcut to assign to `xcfe4-screenshooter -rc` (ex. `Ctrl+Alt+S`) 

5. The command and its assigned shortcut will appear in the **Application Shortcuts** list and can be edited as needed.

    ![EOS keyboard application on the shortcuts tab with the new `xfce4-screenshooter -rc` shortcut selected.](./images/xfce-shortcut-3.png)

---

This shortcut runs the `xfce4-screenshooter` program when the shortcut is pressed with the additional `-r` and `-c` options. From the [`xfce4-screenshooter` manpage](https://man.archlinux.org/man/xfce4-screenshooter.1):

```bash
Application Options:
  -r, --region        Select a region to be captured by clicking a point of the screen without releasing the mouse button, dragging your mouse to the other corner of the region, and releasing the mouse button.

  -c, --clipboard     Copy the screenshot to the clipboard
```

To see the full list of `xfce4-screenshooter` options in the terminal, enter:
  ```bash
  xfce4-screenshooter --help
  ```

> See [**`xfce4-screenshooter`** usage](https://docs.xfce.org/apps/xfce4-screenshooter/usage) | [**`xfce4-screenshooter`** (manpage)](https://man.archlinux.org/man/xfce4-screenshooter.1)

[Top of page](#other-topics)


---
<!-- TO DO LIST
#########################################
### Autosave fullscreen screenshot

The command to automatically save a fullscreen screenshot without being prompted to enter a filename is:
  ```bash
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