if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ;;  <cmd>Telescope buffers<cr>
nnoremap <silent> \\  <cmd>Telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF
