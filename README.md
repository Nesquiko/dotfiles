# Dotfiles

GNU Stow packages for Neovim, tmux, lazygit, yazi, Hyprland, and agent skills.

Run `./apply.sh --dry-run` to inspect the links, then `./apply.sh` to apply them.
The script refuses to overwrite existing files. Back up and move conflicting
files before applying.

## Hyprland

The `hypr-common` package contains shared appearance, keyboard layouts, core
keybindings, and window rules under `~/.config/hypr/shared/`. Each machine's
entry point loads those files and supplies its terminal, browser, file manager,
and application launcher.

The `hypr` package is the ThinkPad profile. It contains `hyprland.lua`, physical
monitor settings, laptop startup apps and shortcuts, Hypridle, Hyprlock,
Hyprpaper, and helper scripts. Apply both packages on the laptop:

```sh
stow --restow --no-folding --target="$HOME" hypr-common hypr
```

Fleet installs only `hypr-common` on flying-dutchman and supplies its machine
entry point from `config/bootstrap/machines/flying-dutchman/hyprland.lua` in the
Fleet repository. Do not install the laptop's `hypr` package on that host.
The headless profile defines a 1080p display without laptop idle suspension.
Streaming services and session startup are configured separately.

Packages are installed separately. The configuration references Alacritty,
Nemo, Wofi, Zen Browser, Waybar, nm-applet, Dunst, Hypridle, Hyprlock,
brightnessctl, WirePlumber, Cliphist, wl-clipboard, Hyprshot, Hyprshade, and
hyprwhspr. It also references the Banana cursor theme and
`~/Wallpapers/todos.png`; the wallpaper is not stored here.

The previous `old_hyprland.conf` backup is not included.
