return {
	"eero-lehtinen/oklch-color-picker.nvim",
	event = "VeryLazy",
	keys = {
		-- One handed keymap recommended, you will be using the mouse
		{
			"<leader>pc",
			function()
				require("oklch-color-picker").pick_under_cursor()
			end,
			desc = "Color pick under cursor",
		},
		{
			"<leader>ch",
			function()
				require("oklch-color-picker").highlight.toggle()
			end,
			desc = "Toggles css colors highlight",
		},
	},
	opts = {
		highlight = {
			enabled = false,
			enabled_lsps = { "tailwindcss", "cssls", "css_variables" },
		},
	},
}
