local builtin = require("telescope.builtin")
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
		preview = {
			filesize_limit = 0.1, -- MB
		},
		path_display = { "filename_first" },
	},
	pickers = {
		lsp_references = {
			theme = "ivy",
		},
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
		live_grep = {
			theme = "ivy",
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>vc", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope find files in nvim config" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })

local function live_grep_with_glob()
	local args = vim.deepcopy(vimgrep_arguments)
	local opts = {
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.99,
			height = 0.99,
			preview_width = 0.6,
		},
	}

	pickers
		.new(opts, {
			prompt_title = "Live Grep",
			finder = finders.new_job(function(prompt)
				if not prompt or prompt == "" then
					return nil
				end

				local globs = {}
				local query = prompt:gsub("glob:([^%s]+)", function(glob)
					table.insert(globs, "--glob=" .. glob)
					return ""
				end)
				query = vim.trim(query)

				if query == "" then
					return nil
				end

				return vim.iter({ args, globs, "--", query }):flatten():totable()
			end, make_entry.gen_from_vimgrep(opts), nil, vim.uv.cwd()),
			previewer = telescopeConfig.values.grep_previewer(opts),
			sorter = sorters.highlighter_only(opts),
			attach_mappings = function(_, map)
				map("i", "<c-space>", actions.to_fuzzy_refine)
				return true
			end,
			push_cursor_on_edit = true,
		})
		:find()
end

vim.keymap.set("n", "<leader>g", live_grep_with_glob, { desc = "Telescope live grep, glob:pattern" })

vim.keymap.set("n", "<leader>t", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>mp", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "Telescope color scheme picker" })
vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, { desc = "Telescope spelling suggestions" })
vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope normal mode keymaps" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy finder" })
vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
