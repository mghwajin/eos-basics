
# xfce4-screenshooter

- [Cursor selection to clipboard](#cursor-selection-to-clipboard)

- [Auto-save fullscreen screenshot](#autosave-fullscreen-screenshot)

---

## Cursor selection to clipboard

This function copies a selected area directly to the clipboard without saving a file. In Windows OS, this is the `Win+Shift+S` shortcut.

1. Open the **Application Shortcuts** tab in your Keyboard application.
    
    ![EOS keyboard application on the shortcuts tab, with a red box highlighting the Add and Edit options/](../eos-basics-images/xfce-shortcut-1.png)

2. Click on the **Add** or **Edit** button to add/edit a shortcut.

3. Enter the following script into the command field:

    ```bash
    xfce4-screenshooter -rc
    ```

    ![EOS keyboard app dialogue window waiting to record keyboard input for the command field.](../eos-basics-images/xfce-shortcut-2.png)

4. When prompted, enter the shortcut to assign to `xcfe4-screenshooter -rc` (ex. `Ctrl+Alt+S`) 

5. The command and its assigned shortcut will appear in the **Application Shortcuts** list and can be edited as needed.

    ![EOS keyboard application on the shortcuts tab with the new `xfce4-screenshooter -rc` shortcut selected.](../eos-basics-images/xfce-shortcut-3.png)

See [**`xfce4-screenshooter`** usage documentation](https://docs.xfce.org/apps/xfce4-screenshooter/usage) for additional functions.

---

## Autosave fullscreen screenshot

```bash
Work in progress... [----C o  o  o  o  o  o  o ]
```

The command to automatically save a fullscreen screenshot without being prompted to enter a filename is:

```bash
xfce4-screenshooter -f -s "$HOME/Desktop/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
```
<!--
Progress notes:  However, the command instead saves a file named `$(date +%Y-%m-%d_%H-%M-%S).png`, which means the shell command is not being accepted as one.
-->

[Back to top](#xfce4-screenshooter) | [Back to README](../README.md)

---