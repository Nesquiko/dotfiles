return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"numToStr/Comment.nvim",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("config.treesitter")
	end,
}
