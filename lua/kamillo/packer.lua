-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- lua/plugins/rose-pine.lua
  use ({
	  "rose-pine/neovim",
	  name = "rose-pine",
	  config = function()
		  require("rose-pine").setup({
			  styles = {
				  transparency = true,
			  },
		  })
		  vim.cmd("colorscheme rose-pine")
	  end
  })

-- lsp
use {
    "folke/lazydev.nvim",
    ft = "lua",
    config = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end
}

use("Bilal2453/luvit-meta", { opt = true })
use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use('nvim-treesitter/playground')
use('theprimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')
use('williamboman/mason.nvim')
use('williamboman/mason-lspconfig.nvim')
use('neovim/nvim-lspconfig')
end)
