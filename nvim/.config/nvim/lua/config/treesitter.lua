local treesitter = require("nvim-treesitter")

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

vim.treesitter.language.register("bash", { "sh" })
vim.treesitter.language.register("json5", { "jsonc" })

-- Lean is not in nvim-treesitter's bundled parser registry.
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("LeanTreesitterParser", { clear = true }),
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").lean = {
			install_info = {
				url = "https://github.com/Julian/tree-sitter-lean",
				revision = "0d28e5d6e8c4755f5df7ef9bde3b6ec6f59fae94",
				queries = "queries",
			},
		}
	end,
})

treesitter.install({
	"bash",
	"bibtex",
	"c",
	"cpp",
	"css",
	"diff",
	"dockerfile",
	"gitignore",
	"graphql",
	"go",
	"gomod",
	"gosum",
	"html",
	"java",
	"javascript",
	"json",
	"json5",
	"kotlin",
	"latex",
	"lean",
	"lua",
	"markdown",
	"markdown_inline",
	"make",
	"ini",
	"query",
	"regex",
	"python",
	"proto",
	"rust",
	"solidity",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
