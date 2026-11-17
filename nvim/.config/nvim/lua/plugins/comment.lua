return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})
		local context_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
		require("Comment").setup({
			pre_hook = function(ctx)
				-- Neovim 0.12 returns nil instead of throwing when a parser is missing.
				local ok, parser = pcall(vim.treesitter.get_parser, 0)
				if not ok or not parser then
					return require("Comment.ft").get(vim.bo.filetype, ctx.ctype) or vim.bo.commentstring
				end
				return context_hook(ctx)
			end,
		})
	end,
}
