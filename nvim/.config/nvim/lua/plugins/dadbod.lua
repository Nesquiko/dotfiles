return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	ft = "sql",
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_win_position = "right"
		vim.g.db_ui_execute_on_save = 0

		vim.keymap.set(
			"n",
			"<leader>rq",
			":normal vip<CR><PLUG>(DBUI_ExecuteQuery)",
			{ desc = "run query under cursor" }
		)
	end,
}
