if !exists('g:lspconfig')
  finish
endif

set completeopt=menu,menuone,noselect

lua << EOF
require("nvim-lsp-installer").setup {}
local nvim_lsp = require('lspconfig')
local util = require ('lspconfig/util')
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_options(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Mappings.

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  
end

local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
        }),
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach
  }, _config or {})
end

-- HTML & CSS
require'lspconfig'.html.setup{
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  filetypes = {"html", "htmldjango", "ejs", "handlebars", "hbs"}
}

require'lspconfig'.cssls.setup{
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
}


-- TAILWIND
require('lspconfig').tailwindcss.setup{
  filetypes = { "html", "javascript", "typescript", "php", "typescriptreact"} 
}

--JAVASCRIPT AND TYPESCRIPT
require'lspconfig'.tsserver.setup{
  on_attach = function(client, bufnr)
    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx"}
    -- Disable default TypeScript server formatting if you prefer to use a different formatter
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

-- GO

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

-- it was super annoying so I commented it. atleast for now.
--nvim_lsp.golangci_lint_ls.setup{}

--nvim_lsp.gopls.setup {
   -- cmd = {"gopls", "serve"},
   -- filetypes = {"go", "gomod"},
   -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
   -- settings = {
    --  gopls = {
      --  analyses = {
       --   unusedparams = true,
       -- },
      --  staticcheck = true,
    --  },
  --  },
 -- }

-- Rust
require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        }
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

-- VIMLS

-- Python:
require("lspconfig").pyright.setup(config({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- Set to "off" to disable type checking, "basic" for basic type checking, or "strict" for strict type checking.
      },
    },
  },
}))

EOF

