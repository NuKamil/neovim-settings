vim.lsp.config('roslyn_ls', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable('roslyn_ls')
