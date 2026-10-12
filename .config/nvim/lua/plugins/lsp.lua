return {
	-- Generic LSP configs for servers other than Haskell.
	-- NOTE: do NOT set up `hls` here (`lspconfig.hls.setup {}` or
	-- `vim.lsp.config("hls", {})` + `vim.lsp.enable("hls")`).
	-- Haskell is managed by haskell-tools.nvim (see lua/plugins/haskell.lua),
	-- which starts its own HLS client and conflicts with a manual setup.
	"neovim/nvim-lspconfig",
}

