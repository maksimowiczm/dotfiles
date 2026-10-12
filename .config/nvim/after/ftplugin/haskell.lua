-- Buffer-local keymaps for Haskell files (haskell-tools.nvim).
-- This runs on FileType=haskell, independent of whether HLS has attached yet.
-- Generic LSP maps (gd, gr, K, <leader>ca, ...) live in
-- `vim.g.haskell_tools.hls.on_attach` (see lua/plugins/haskell.lua).
local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, vim.tbl_extend("force", opts, { desc = "Hoogle signature search" }))
-- Evaluate all code snippets
vim.keymap.set("n", "<leader>ea", ht.lsp.buf_eval_all, vim.tbl_extend("force", opts, { desc = "Evaluate all snippets" }))
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", ht.repl.toggle, vim.tbl_extend("force", opts, { desc = "Toggle GHCi repl (package)" }))
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, vim.tbl_extend("force", opts, { desc = "Toggle GHCi repl (file)" }))
vim.keymap.set("n", "<leader>rq", ht.repl.quit, vim.tbl_extend("force", opts, { desc = "Quit GHCi repl" }))
