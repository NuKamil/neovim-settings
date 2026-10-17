require('conform').setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },

  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype
    if filetype == 'c' or filetype == 'cpp' then return end

    return {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    }
  end,

  formatters_by_ft = {
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    vue = { 'prettier' },
    json = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    html = { 'prettier' },
  },
}
