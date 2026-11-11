vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {}

local capabilities = require('blink.cmp').get_lsp_capabilities()

local vue_language_server_path = vim.fs.joinpath(
  vim.fn.stdpath('data'),
  'mason',
  'packages',
  'vue-language-server',
  'node_modules',
  '@vue',
  'language-server'
)

vim.lsp.config('vtsls', {
  capabilities = capabilities,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
          },
          {
            -- o365dev: rozwiązuje importy z kropkami (./legacy.X.ts → ./legacy/X.ts), lib/plik.ts, SiteSetup.
            -- Konfiguracja (sitesetupDir itd.) przychodzi z tsconfig.json biblioteki/apki.
            name = '@o365dev/tsconfig-plugin',
            location = 'C:/Users/kamil.nurkowski/O365-Workspace',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
})

for _, server in ipairs { 'vue_ls', 'html', 'cssls', 'tailwindcss' } do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

vim.lsp.enable {
  'vtsls',
  'vue_ls',
  'html',
  'cssls',
  'tailwindcss',
}
