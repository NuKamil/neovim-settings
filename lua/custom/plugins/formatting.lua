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
    javascript = { 'prettier_tabs' },
    javascriptreact = { 'prettier_tabs' },
    typescript = { 'prettier_tabs' },
    typescriptreact = { 'prettier_tabs' },
    json = { 'prettier_tabs' },
    css = { 'prettier_tabs' },
    scss = { 'prettier_tabs' },
    vue = { 'prettier_tabs_120' },
    html = { 'prettier_tabs_120' },
  },

  formatters = {
    -- Tabs (width 4) everywhere; default print width (80).
    prettier_tabs = {
      inherit = 'prettier',
      append_args = { '--use-tabs', '--tab-width', '4' },
    },
    -- Vue and HTML: same tabs, but lines up to 120, so short tags stay on one line.
    prettier_tabs_120 = {
      inherit = 'prettier',
      append_args = { '--use-tabs', '--tab-width', '4', '--print-width', '120' },
    },
  },
}

-- Edit with tabs (width 4) in the same file types, to match the formatter.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-tab-indent', { clear = true }),
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'css', 'scss', 'html', 'vue' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
})
