return {
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^10",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			vim.g.haskell_tools = {
				hls = {
					on_attach = function(_, bufnr)
						local opts = { noremap = true, silent = true, buffer = bufnr }
						-- Defaults are fine for tools.codeLens.autoRefresh, tools.hover, etc.
						-- Buffer-local LSP keymaps (only active when HLS attaches).
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Goto definition" }))
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
						vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Goto type definition" }))
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Goto implementation" }))
						vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
						vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
						vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
						vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run code lens" }))
						vim.keymap.set("n", "[d", function()
							vim.diagnostic.jump({ count = -1 })
						end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
						vim.keymap.set("n", "]d", function()
							vim.diagnostic.jump({ count = 1 })
						end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
						vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
						-- Uncomment to enable inlay hints where HLS provides them:
						if vim.lsp.inlay_hint then
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end
					end,
					default_settings = {
						haskell = {
							-- Must match the formatter in conform.nvim (`formatters_by_ft.haskell`).
							formattingProvider = "fourmolu",
							checkProject = true,
							checkParents = "CheckOnSave",
							maxCompletions = 40,
						},
					},
				},
			}
		end,
	},
}
