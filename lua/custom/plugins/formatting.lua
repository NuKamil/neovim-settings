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
    vue = { 'prettier_vue_tabs' },
    json = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    html = { 'prettier' },
  },

  formatters = {
    -- Vue: taby o szerokości 4, linia 120. Krótkie tagi zostają w jednej linii,
    -- długie prettier nadal łamie (domyślne reguły atrybutów bez zmian).
    prettier_vue_tabs = {
      inherit = 'prettier',
      append_args = { '--use-tabs', '--tab-width', '4', '--print-width', '120' },
    },
  },
}
