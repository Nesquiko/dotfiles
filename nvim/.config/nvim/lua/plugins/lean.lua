return {
	"Julian/lean.nvim",
	event = { "BufReadPre *.lean", "BufNewFile *.lean" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	keys = {
		{ "<leader>i", "<cmd>LeanInfoviewToggle<CR>", ft = "lean", desc = "Lean toggle infoview" },
		{ "<leader>li", "<cmd>LeanInfoviewToggle<CR>", ft = "lean", desc = "Lean toggle infoview" },
		{ "<leader>lx", "<cmd>LeanInfoviewAddPin<CR>", ft = "lean", desc = "Lean pin goal" },
		{ "<leader>lc", "<cmd>LeanInfoviewClearPins<CR>", ft = "lean", desc = "Lean clear pins" },
		{ "<leader>lp", "<cmd>LeanInfoviewPinTogglePause<CR>", ft = "lean", desc = "Lean pause pin" },
		{ "<leader>lv", "<cmd>LeanGotoInfoview<CR>", ft = "lean", desc = "Lean go to infoview" },
		{ "<leader>lr", "<cmd>LeanRestartFile<CR>", ft = "lean", desc = "Lean restart file" },
	},
	init = function()
		-- Lean's suggested local-leader mappings overlap with our global mappings.
		vim.g.lean_config = { mappings = false }
	end,
	config = function()
		require("config.lean")
	end,
}
