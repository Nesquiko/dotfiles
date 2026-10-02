return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("config.lsp")
	end,
}
