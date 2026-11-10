-- Shared appearance, keyboard layouts, and pointer settings.
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 3,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = false,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		col = {
			splash = 0xff000000,
		},
	},
	input = {
		kb_layout = "us,sk",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		-- sensitivity = -0.5,
		sensitivity = 0,
	},
})
