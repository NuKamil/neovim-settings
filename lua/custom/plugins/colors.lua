return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			if vim.g.neovide then
				vim.g.neovide_opacity = 0.92
				vim.g.neovide_normal_opacity = 0.92
			end
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				extend_background_behind_borders = true,
				styles = {
					transparency = false,
				},
			})

			vim.cmd.colorscheme("rose-pine")

			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
		end,
	},
}
