-- Set filetype to html for .ftl files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ftl",
	callback = function()
		vim.bo.filetype = "html"
	end,
})
