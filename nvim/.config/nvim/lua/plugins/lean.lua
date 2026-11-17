return {
	"Julian/lean.nvim",
	event = { "BufReadPre *.lean", "BufNewFile *.lean" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	init = function()
		vim.g.lean_config = { mappings = true }
	end,
	config = function()
		vim.lsp.config("leanls", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
