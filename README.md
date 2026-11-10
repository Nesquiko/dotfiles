# Dotfiles

GNU Stow packages for Neovim, tmux, lazygit, yazi, Hyprland, and agent skills.

Run `./apply.sh --dry-run` to inspect the links, then `./apply.sh` to apply them.
The script refuses to overwrite existing files. Back up and move conflicting
files before applying.

## Hyprland

The `hypr` package contains the laptop's Hyprland Lua configuration, Hypridle,
Hyprlock, Hyprpaper, and helper scripts. To apply only this package:

```sh
stow --restow --no-folding --target="$HOME" hypr
```

Monitor names and positions are specific to the ThinkPad and its external
monitors. Review them before using this package on another machine. Hypridle
suspends the machine after 30 minutes, so this configuration needs adapting
before use on a streaming host.

Packages are installed separately. The configuration references Alacritty,
Nemo, Wofi, Zen Browser, Waybar, nm-applet, Dunst, Hypridle, Hyprlock,
brightnessctl, WirePlumber, Cliphist, wl-clipboard, Hyprshot, Hyprshade, and
hyprwhspr. It also references the Banana cursor theme and
`~/Wallpapers/todos.png`; the wallpaper is not stored here.

The previous `old_hyprland.conf` backup is not included.
