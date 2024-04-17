lua << EOF

-- Prettier settings in Lua
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0

-- Auto commands for Prettier using Neovim's Lua API
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.js", "*.ts", "*.css", "*.less", "*.scss", "*.json", "*.graphql", "*.md", "*.vue", "*.html", "*.yaml"},
    command = "PrettierAsync"
})


EOF
