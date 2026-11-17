vim.lsp.config("leanls", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local group = vim.api.nvim_create_augroup("LeanInfoviewCleanup", { clear = true })

local function has_lean_window(tab, excluded)
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
		if win ~= excluded and vim.api.nvim_win_get_config(win).relative == "" then
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.bo[buf].filetype == "lean" and vim.bo[buf].buftype == "" then
				return true
			end
		end
	end
	return false
end

-- Close before :q/:wq so Neovim can exit normally instead of leaving the
-- infoview as the last window. Keep it when another Lean split is still open.
vim.api.nvim_create_autocmd("QuitPre", {
	group = group,
	callback = function()
		if vim.bo.filetype ~= "lean" then
			return
		end
		local tab = vim.api.nvim_get_current_tabpage()
		if not has_lean_window(tab, vim.api.nvim_get_current_win()) then
			require("lean.infoview").close()
		end
	end,
})

-- :bdelete and window API calls also need cleanup, after the buffer/window
-- has actually disappeared. Capture the tab so a later tab switch is harmless.
vim.api.nvim_create_autocmd({ "BufWinLeave", "WinClosed" }, {
	group = group,
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		local infoview = require("lean.infoview").get_current_infoview()
		vim.schedule(function()
			if infoview and vim.api.nvim_tabpage_is_valid(tab) and not has_lean_window(tab) then
				infoview:close()
			end
		end)
	end,
})
