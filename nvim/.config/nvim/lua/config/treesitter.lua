local treesitter = require("nvim-treesitter")

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

vim.treesitter.language.register("bash", { "sh" })
vim.treesitter.language.register("json5", { "jsonc" })

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
