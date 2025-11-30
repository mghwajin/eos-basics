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