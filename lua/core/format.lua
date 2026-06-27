local M = {}

function M.format_buffer(opts)
	opts = opts or {}

	local ok, conform = pcall(require, "conform")
	if ok then
		conform.format(vim.tbl_extend("force", {
			async = true,
			lsp_format = "fallback",
			timeout_ms = 1000,
		}, opts))
		return
	end

	vim.lsp.buf.format({ async = true })
end

return M
