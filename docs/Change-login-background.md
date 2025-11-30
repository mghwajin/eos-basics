
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