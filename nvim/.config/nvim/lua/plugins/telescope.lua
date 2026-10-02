return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("config.telescope")
	end,
}
