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

cmp.setup({
   snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
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
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }),
    formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
  })

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = on_attach
	}, _config or {})
end


--JAVASCRIPT AND TYPESCRIPT

require("lspconfig").tsserver.setup(config())

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

-- tailwind

nvim_lsp.tailwindcss.setup{}

-- VIMLS
EOF

