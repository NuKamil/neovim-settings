-- Theme plugins live here; the active theme is selected in init.lua.
return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'moon',
      dark_variant = 'moon',
      extend_background_behind_borders = true,
      styles = { transparency = true },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'moon',
      transparent = true,
      styles = { comments = { italic = false } },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
    end,
  },
}
