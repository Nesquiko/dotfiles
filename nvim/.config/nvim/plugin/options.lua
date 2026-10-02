local options = {
	backup = true, -- creates a backup file
	backupdir = vim.fn.stdpath("cache") .. "/backup", -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 0, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
	termguicolors = true, -- set term gui colors (most terminals support this)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = false, -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 4 spaces for a tab
	cursorline = true, -- highlight the current line
	guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20",
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- minimal number of lines to keep above and below the cursor
	sidescrolloff = 8, -- minimal number of screen columns to keep to the left and to the right of the cursor
	colorcolumn = "80", -- displays vertical line at column 80
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- allows moving to the next/previous line from first/last charachter.
vim.cmd("set whichwrap+=<,>,[,],h,l")
-- makes - behave like a part of a word
vim.cmd("set iskeyword+=-")
-- default formmatting settings, usually overwritten by plugins
-- c = autowraps commenst
-- r = automatically inserts comment after hitting <Enter>
-- o = automatically inserts comment after hitting o or O, quickly delete with <C-U>
vim.cmd("set formatoptions-=cro")

vim.g.tex_flavor = "latex"
