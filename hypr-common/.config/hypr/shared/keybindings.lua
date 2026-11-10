-- Each profile supplies its own applications for the same launch shortcuts.
return function(programs)
	local terminal = assert(programs.terminal)
	local browser = assert(programs.browser)
	local fileManager = assert(programs.file_manager)
	local menu = assert(programs.menu)
	local mainMod = "SUPER"
	local function combo(...)
		return table.concat({ ... }, " + ")
	end

	hl.bind(combo(mainMod, "Return"), hl.dsp.exec_cmd(terminal))
	hl.bind(combo(mainMod, "B"), hl.dsp.exec_cmd(browser))
	hl.bind(combo(mainMod, "Q"), hl.dsp.window.kill())
	hl.bind(combo(mainMod, "SHIFT", "M"), hl.dsp.exit())
	hl.bind(combo(mainMod, "E"), hl.dsp.exec_cmd(fileManager))
	hl.bind(combo(mainMod, "V"), hl.dsp.window.float({ action = "toggle" }))
	hl.bind(combo(mainMod, "D"), hl.dsp.exec_cmd(menu))
	hl.bind(combo(mainMod, "P"), hl.dsp.window.pseudo({ action = "toggle" }))

	-- Move focus with mainMod + arrow keys
	hl.bind(combo(mainMod, "left"), hl.dsp.focus({ direction = "l" }))
	hl.bind(combo(mainMod, "right"), hl.dsp.focus({ direction = "r" }))
	hl.bind(combo(mainMod, "up"), hl.dsp.focus({ direction = "u" }))
	hl.bind(combo(mainMod, "down"), hl.dsp.focus({ direction = "d" }))

	-- Move focus with mainMod + HJKL
	hl.bind(combo(mainMod, "H"), hl.dsp.focus({ direction = "l" }))
	hl.bind(combo(mainMod, "L"), hl.dsp.focus({ direction = "r" }))
	hl.bind(combo(mainMod, "K"), hl.dsp.focus({ direction = "u" }))
	hl.bind(combo(mainMod, "J"), hl.dsp.focus({ direction = "d" }))

	-- Switch workspaces with mainMod + [0-9]
	hl.bind(combo(mainMod, "1"), hl.dsp.focus({ workspace = 1 }))
	hl.bind(combo(mainMod, "2"), hl.dsp.focus({ workspace = 2 }))
	hl.bind(combo(mainMod, "3"), hl.dsp.focus({ workspace = 3 }))
	hl.bind(combo(mainMod, "4"), hl.dsp.focus({ workspace = 4 }))
	hl.bind(combo(mainMod, "5"), hl.dsp.focus({ workspace = 5 }))
	hl.bind(combo(mainMod, "6"), hl.dsp.focus({ workspace = 6 }))
	hl.bind(combo(mainMod, "7"), hl.dsp.focus({ workspace = 7 }))
	hl.bind(combo(mainMod, "8"), hl.dsp.focus({ workspace = 8 }))
	hl.bind(combo(mainMod, "9"), hl.dsp.focus({ workspace = 9 }))
	hl.bind(combo(mainMod, "0"), hl.dsp.focus({ workspace = 10 }))

	-- Move active window to a workspace with mainMod + SHIFT + [0-9]
	hl.bind(combo(mainMod, "SHIFT", "1"), hl.dsp.window.move({ workspace = 1 }))
	hl.bind(combo(mainMod, "SHIFT", "2"), hl.dsp.window.move({ workspace = 2 }))
	hl.bind(combo(mainMod, "SHIFT", "3"), hl.dsp.window.move({ workspace = 3 }))
	hl.bind(combo(mainMod, "SHIFT", "4"), hl.dsp.window.move({ workspace = 4 }))
	hl.bind(combo(mainMod, "SHIFT", "5"), hl.dsp.window.move({ workspace = 5 }))
	hl.bind(combo(mainMod, "SHIFT", "6"), hl.dsp.window.move({ workspace = 6 }))
	hl.bind(combo(mainMod, "SHIFT", "7"), hl.dsp.window.move({ workspace = 7 }))
	hl.bind(combo(mainMod, "SHIFT", "8"), hl.dsp.window.move({ workspace = 8 }))
	hl.bind(combo(mainMod, "SHIFT", "9"), hl.dsp.window.move({ workspace = 9 }))
	hl.bind(combo(mainMod, "SHIFT", "0"), hl.dsp.window.move({ workspace = 10 }))

	-- Example special workspace (scratchpad)
	hl.bind(combo(mainMod, "S"), hl.dsp.workspace.toggle_special("magic"))
	hl.bind(combo(mainMod, "SHIFT", "S"), hl.dsp.window.move({ workspace = "special:magic" }))

	-- Scroll through existing workspaces with mainMod + scroll
	hl.bind(combo(mainMod, "mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
	hl.bind(combo(mainMod, "mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

	-- Move/resize windows with mainMod + LMB/RMB and dragging
	hl.bind(combo(mainMod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
	hl.bind(combo(mainMod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd([[wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+]]),
		{ repeating = true, locked = true }
	)
	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd([[wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-]]),
		{ repeating = true, locked = true }
	)
	hl.bind(
		"XF86AudioMute",
		hl.dsp.exec_cmd([[wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle]]),
		{ repeating = true, locked = true }
	)
	hl.bind(
		"XF86AudioMicMute",
		hl.dsp.exec_cmd([[wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle]]),
		{ repeating = true, locked = true }
	)
	-- Go to next monitor
	hl.bind(combo(mainMod, "CTRL", "H"), hl.dsp.workspace.move({ monitor = "l" }))
	hl.bind(combo(mainMod, "CTRL", "L"), hl.dsp.workspace.move({ monitor = "r" }))
	hl.bind(combo(mainMod, "CTRL", "K"), hl.dsp.workspace.move({ monitor = "+1" }))
	hl.bind(combo(mainMod, "CTRL", "J"), hl.dsp.workspace.move({ monitor = "-1" }))

	hl.bind(combo(mainMod, "F"), hl.dsp.window.fullscreen({ action = "toggle" }))
end
