vim.api.nvim_create_user_command("NvimConfigCheck", function()
	require("health.config").check()
end, {
	desc = "Run health checks for this Neovim config",
})
