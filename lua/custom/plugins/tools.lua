require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server',
    'stylua',
    'roslyn-language-server',
    'vue-language-server',
    'vtsls',
    'html-lsp',
    'css-lsp',
    'tailwindcss-language-server',
    'prettier',
  },
  run_on_start = true,
  auto_update = false,
}
