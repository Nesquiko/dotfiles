require("fidget").setup({})
require("mason").setup()

local to_install = {
	-- LSPs
	"lua_ls",
	"gopls",
	"rust_analyzer",
	"tailwindcss",
	"bashls",
	"marksman",
	-- "kotlin_lsp",
	-- "jdtls",
	"solidity_ls_nomicfoundation",

	-- Formaters
	"stylua",
	"prettier",
	"gofumpt",
	"goimports-reviser",
	"golines",
	"shfmt",

	-- Linters
	"staticcheck",
	"shellcheck",
}

local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

vim.lsp.config("tsc", {
	capabilities = vim.tbl_deep_extend("force", { documentFormattingProvider = false }, capabilities),
})
vim.lsp.enable("tsc")

-- vim.lsp.config("kotlin_lsp", {
-- 	cmd = { "intellij-server", "--stdio" },
-- 	capabilities = capabilities,
-- })
-- vim.lsp.config("jdtls", {
-- 	capabilities = capabilities,
-- 	init_options = {
-- 		extendedClientCapabilities = {
-- 			classFileContentsSupport = true,
-- 		},
-- 	},
-- 	cmd = function(dispatchers, config)
-- 		-- Keep project indexes isolated even when unrelated projects share a directory name.
-- 		local workspace = vim.fs.joinpath(vim.fn.stdpath("cache"), "jdtls", vim.fn.sha256(config.root_dir))
-- 		return vim.lsp.rpc.start({ "jdtls", "-data", workspace }, dispatchers, {
-- 			cwd = config.cmd_cwd,
-- 			env = config.cmd_env,
-- 			detached = config.detached,
-- 		})
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("BufReadCmd", {
-- 	pattern = "jdt://*",
-- 	callback = function(args)
-- 		local client = vim.lsp.get_clients({ bufnr = vim.fn.bufnr("#"), name = "jdtls" })[1]
-- 			or vim.lsp.get_clients({ name = "jdtls" })[1]
-- 		if not client then
-- 			return
-- 		end
--
-- 		vim.bo[args.buf].buftype = "nofile"
-- 		vim.bo[args.buf].swapfile = false
-- 		vim.bo[args.buf].filetype = "java"
-- 		vim.bo[args.buf].modifiable = true
-- 		local content
-- 		client:request("java/classFileContents", { uri = args.match }, function(err, result)
-- 			content = result
-- 			if err or not content then
-- 				vim.notify("Could not load Java class contents", vim.log.levels.ERROR)
-- 				return
-- 			end
-- 			vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, vim.split(content, "\n", { plain = true }))
-- 			vim.bo[args.buf].modifiable = false
-- 		end, args.buf)
-- 		-- Neovim positions the cursor immediately after this event; wait for JDTLS
-- 		-- so the requested definition line is already present in the buffer.
-- 		vim.wait(5000, function()
-- 			return content ~= nil
-- 		end)
-- 	end,
-- })

require("mason-tool-installer").setup({ ensure_installed = to_install })

local augroup = vim.api.nvim_create_augroup("RustFormatting", {})

local function rust_on_attach(client, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

require("mason-lspconfig").setup({
	automatic_installation = false,
	ensure_installed = {},
	handlers = {
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
		["gopls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				capabilities = vim.tbl_deep_extend("force", { documentFormattingProvider = false }, capabilities),
				settings = {
					gopls = {
						buildFlags = { "-tags=integration,e2e" },
					},
				},
			})
		end,
		["denols"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.denols.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})
		end,
		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "Lua 5.1" },
						diagnostics = {
							globals = { "bit", "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files, inspired by https://www.reddit.com/r/neovim/comments/x3bd4i/how_can_i_get_lsp_to_recognize_builtin_neovim_api/
							library = vim.api.nvim_get_runtime_file("lua", true),
						},
					},
				},
			})
		end,
		["rust_analyzer"] = function()
			-- NOTE if you are looking for how to not dim code behind cfg, maybe look at this https://stackoverflow.com/a/79387930
			local lspconfig = require("lspconfig")
			local cargo_config = ".cargo/config.toml"
			local settings = {
				["rust-analyzer"] = {
					-- cargo = {
					-- 	allTargets = false,
					-- 	buildScripts = { enable = false },
					-- },
					-- check = { allTargets = false },
					-- procMacro = { enable = false },
				},
			}

			local exists = vim.loop.fs_stat(cargo_config)
			if exists then
				for line in io.lines(cargo_config) do
					local target = line:match('^%s*target%s*=%s*"([^"]+)"')
					if target then
						settings["rust-analyzer"].cargo.target = target
						break
					end
				end
			end

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = rust_on_attach,
				settings = settings,
			})
		end,
	},
})
