require('base')
require('highlights')
require('maps')
require('plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_linux = has "linux"

if is_mac then
  require('macos')
end

if is_linux then
  require('linux')
end

vim.cmd 'colorscheme material'
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
