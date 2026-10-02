-- Modes:
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c"

---Function for mapping keybinds.
---Default options:
---	remap = true
--- 	silent = true
---
---@param mode string|table in which mode the cmd will execute
---@param keys string key sequence/combination
---@param cmd string|function command which will be executed
---@param options table|nil optional options
function Map(mode, keys, cmd, options)
	options = options or { noremap = true, silent = true }
	vim.keymap.set(mode, keys, cmd, options)
end

--Remap space as leader key
Map("", "<Space>", "<Nop>")
-- set in config/lazy.lua, because lazy needs it like that
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- ########## Normal ########## --

-- Switching between windows
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
Map("n", "<C-Up>", ":resize -1<CR>")
Map("n", "<C-Down>", ":resize +1<CR>")
Map("n", "<C-Left>", ":vertical resize +1<CR>")
Map("n", "<C-Right>", ":vertical resize -1<CR>")

Map("n", "<leader>x", ":bdelete<CR>")
Map("n", "<leader>rn", "<cmd>restart<CR>")

-- Center to cursor with C-d and C-u
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")

-- ########## Insert ########## --

-- Escape is too far away...
Map("i", "jk", "<ESC>")

-- ########## Visual ########## --

-- Stay in indent mode when indenting
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
Map("v", "y", "myy`hay")
Map("v", "Y", "myY`y")

-- Does not yank after selecting and pasting
Map("x", "p", '"_dP')

-- ########## Visual Block ########## --

-- ########## Terminal ########## --

local term_opts = { silent = true }

-- Better terminal navigation
Map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
Map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
Map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
Map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- quickfix list
Map("n", "<M-j>", "<cmd>cnext<CR>")
Map("n", "<M-k>", "<cmd>cprev<CR>")
