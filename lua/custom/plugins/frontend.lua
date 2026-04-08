return {
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      local ok, ts_install = pcall(require, 'nvim-treesitter.install')
      if ok then
        ts_install.compilers = { 'gcc', 'cl', 'clang' }
      end
    end,
  },
}
