vim.api.nvim_create_user_command("NvimConfigCheck", function()
	vim.cmd("checkhealth config")
end, {
	desc = "Run health checks for this Neovim config",
})
