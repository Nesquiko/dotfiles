-- ThinkPad profile. Fleet supplies a separate entry point on flying-dutchman.
local config = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
local shared = config .. "/hypr/shared/"
local programs = {
	terminal = "alacritty",
	file_manager = "nemo",
	menu = "wofi --show drun --gtk-dark",
	browser = "zen-browser",
}
local terminal = programs.terminal
local mainMod = "SUPER"
local function combo(...)
	return table.concat({ ... }, " + ")
end

dofile(shared .. "settings.lua")
dofile(shared .. "keybindings.lua")(programs)
dofile(shared .. "window-rules.lua")

-- main laptop monitor
hl.monitor({ output = "eDP-1", mode = "1920x1080@60.02", position = "0x0", scale = 1 })
-- Left: Dell
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "-1920x0", scale = 1 })
-- Right: AOC
hl.monitor({ output = "DP-1", mode = "2560x1440@59.95", position = "1920x0", scale = 1 })

-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

hl.env("SSH_ASKPASS", "ksshaskpass")
hl.env("SSH_ASKPASS_REQUIRE", "prefer")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_SIZE", "48")

hl.on("hyprland.start", function()
	hl.exec_cmd([[systemctl --user start /usr/lib/polkit-kde-authentication-agent-1]])
	hl.exec_cmd([[waybar]])
	hl.exec_cmd([[nm-applet]])
	hl.exec_cmd([[hypridle]])
	hl.exec_cmd([[dunst]])
	hl.exec_cmd([[wl-paste --type text --watch cliphist store]])
	hl.exec_cmd([[wl-paste --type image --watch cliphist store]])
	hl.exec_cmd([[hyprctl setcursor "Banana" 48]])
	hl.exec_cmd([[gsettings set org.gnome.desktop.interface cursor-theme "Banana"]])
	hl.exec_cmd([[gsettings set org.gnome.desktop.interface cursor-size 48]])
	hl.exec_cmd(terminal)
	hl.exec_cmd([[tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"]])
end)

-- Laptop devices and shortcuts.
hl.config({ input = { touchpad = { natural_scroll = false } } })
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[brightnessctl s 10%+]]), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[brightnessctl s 10%-]]), { repeating = true, locked = true })

hl.bind(combo(mainMod, "SHIFT", "W"), hl.dsp.exec_cmd([[pkill waybar && hyprctl dispatch exec waybar]]))
hl.bind(
	combo(mainMod, "SHIFT", "V"),
	hl.dsp.exec_cmd([[cliphist list | wofi --dmenu --gtk-dark | cliphist decode | wl-copy]])
)

hl.bind(combo(mainMod, "SHIFT", "X"), hl.dsp.exec_cmd([[hyprlock]]))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd([[hyprlock & systemctl suspend]]))

-- HYPRSHOT
-- Screenshot a window
hl.bind(combo(mainMod, "PRINT"), hl.dsp.exec_cmd([[hyprshot -m window -o /tmp]]))
-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd([[hyprshot -m output -o /tmp]]))
-- Screenshot a region
hl.bind(combo(mainMod, "SHIFT", "PRINT"), hl.dsp.exec_cmd([[hyprshot -m region -o /tmp]]))

-- hyprwhspr - Toggle mode (added by hyprwhspr setup)
-- Press once to start, press again to stop
hl.bind(
	combo(mainMod, "ALT", "D"),
	hl.dsp.exec_cmd([[/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record]]),
	{ description = "Speech-to-text" }
)
