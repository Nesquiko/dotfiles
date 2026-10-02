local conform = require("conform")
local fidget = require("fidget")

local auto_formatting_enabled = true

local function format()
	conform.format({
		async = false,
		lsp_format = "fallback",
		filter = function(client)
			return client.name ~= "tsc" and client.name ~= "solidity_ls_nomicfoundation"
		end,
	})
end

local function auto_format()
	if not auto_formatting_enabled then
		fidget.notify("Formatting is disabled", vim.log.levels.WARN, { key = "formatting_toggle" })
		return
	end
	format()
end

local function toggle_format_on_save()
	auto_formatting_enabled = not auto_formatting_enabled
	fidget.notify(
		"Formatting " .. (auto_formatting_enabled and "enabled" or "disabled"),
		vim.log.levels.INFO,
		{ key = "formatting_toggle" }
	)
end

vim.api.nvim_create_user_command("FormatToggle", toggle_format_on_save, {})

-- Helper function to check if root has file
local function root_has_file(files)
	local root = vim.fs.root(0, files)
	return root ~= nil
end

-- Select formatter based on config files present
local function select_js_formatter(bufnr)
	if root_has_file({ "biome.json", "biome.jsonc" }) then
		return { "biome" }
	elseif root_has_file({ ".oxfmtrc.json" }) then
		return { "oxfmt" }
	else
		return { "prettier" }
	end
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },

		-- JavaScript/TypeScript with biome, oxfmt, or prettier fallback
		javascript = select_js_formatter,
		typescript = select_js_formatter,
		javascriptreact = select_js_formatter,
		typescriptreact = select_js_formatter,
		json = select_js_formatter,
		jsonc = select_js_formatter,
		markdown = select_js_formatter,

		-- Go formatters
		go = { "gofumpt", "goimports_reviser", "golines" },

		-- Shell scripts
		sh = { "shfmt" },
		bash = { "shfmt" },

		-- Solidity
		solidity = { "forge_fmt" },

		-- Python
		python = { "black" },

		-- SQL
		sql = { "pg_format" },

		-- Elixir
		elixir = { "mix" },
	},

	formatters = {
		pg_format = {
			prepend_args = { "-u", "1", "-U", "1", "-f", "1", "--no-space-function" },
		},
	},
})

-- Set up format on save autocmd
local augroup = vim.api.nvim_create_augroup("ConformFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = "*",
	callback = auto_format,
})

-- Set up keymaps
vim.keymap.set("n", "<leader>l", format, { desc = "Formats current buffer" })
vim.keymap.set("n", "<leader>tf", toggle_format_on_save, { desc = "Togles auto formatting" })
