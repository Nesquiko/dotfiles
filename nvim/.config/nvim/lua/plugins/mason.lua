return {
	"williamboman/mason.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"j-hui/fidget.nvim",
	},
	config = function()
		require("config.mason")
	end,
}
