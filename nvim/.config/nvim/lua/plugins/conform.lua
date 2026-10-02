return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = function()
		return require("config.conform")
	end,
}
