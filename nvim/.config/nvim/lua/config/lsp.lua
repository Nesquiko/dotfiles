vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local builtin = require("telescope.builtin")
		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = function(desc)
			return { buffer = args.buf, desc = desc }
		end

		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts("Telescope go to or list definitions"))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts("Telescope go to or list implementations"))
		vim.keymap.set("n", "gr", function()
			builtin.lsp_references({ fname_width = 45 })
		end, opts("Telescope list references"))
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts("Go to type definition"))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Details for word under the cursor"))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Shows code actions"))
		vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts("Renames all occurrences"))
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts("Go to next diagnostic item"))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts("Go to previous diagnostic item"))
		vim.keymap.set("n", "<leader>ic", builtin.lsp_incoming_calls, opts("Telescope show incoming function calls"))
		vim.keymap.set("n", "<leader>oc", builtin.lsp_outgoing_calls, opts("Telescope show outgoing function calls"))
		vim.keymap.set("n", "<leader>dw", builtin.diagnostics, opts("Telescope show diagnostics for whole wokspace"))
		vim.keymap.set(
			"n",
			"<leader>dc",
			vim.diagnostic.open_float,
			opts("Opens diagnostics floating window for line under cursor")
		)

		vim.keymap.set("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts("Toggles inlay hints"))
	end,
})
