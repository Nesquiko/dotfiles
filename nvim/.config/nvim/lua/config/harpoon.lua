local harpoon = require("harpoon")

local function project_branch_key()
	local project = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
	if vim.v.shell_error ~= 0 or not project then
		return vim.loop.cwd()
	end

	local branch = vim.fn.systemlist({ "git", "branch", "--show-current" })[1]
	if vim.v.shell_error ~= 0 or not branch or branch == "" then
		branch = vim.fn.systemlist({ "git", "rev-parse", "--short", "HEAD" })[1] or "detached"
	end

	return project .. "::" .. branch
end

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
		key = project_branch_key,
	},
})

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon add current file" })

vim.keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon file list" })

for index = 1, 4 do
	vim.keymap.set("n", "<leader>" .. index, function()
		harpoon:list():select(index)
	end, { desc = "Harpoon go to file " .. index })
end
