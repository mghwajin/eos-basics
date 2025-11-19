# Other topics

- [`git clone` to location](#git-clone-to-location)
- [Change login background](#change-login-background)
- [`Nvidia-settings` config issues](#nvidia-settings-config-issues)

---

## git clone to location

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

![Login Window GUI editor on the Appearance options tab, which contains options for General, Background, Themes, and Optional pictures selections.](../eos-basics-images/login-window-gui.png)

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

## Nvidia-settings config issues

```bash
Work in progress... [----C o  o  o  o  o  o  o ]
```
<!-- 
Progress notes: Potentially an issue of the Nvidia GPU not properly loading upon boot, which would prevent the nvidia-settings configs from applying.
[eoswiki](https://discovery.endeavouros.com/nvidia/nvidia-optional-enhancements-and-troubleshooting/2021/03/)
[archwiki](https://wiki.archlinux.org/title/NVIDIA#Early_loading)

Need to set up force early load (**dracut**, not mkinitcpio).
-->

> See [Nvidia ArchWiki page](https://wiki.archlinux.org/title/NVIDIA#NVIDIA_Settings) |  [Troubleshooting forum](https://forum.endeavouros.com/t/nvidia-settings-isnt-remembering-my-config-changes/3089/6) \
> [Top of section](#other-topics) | [Back to README](../README.md)

---
