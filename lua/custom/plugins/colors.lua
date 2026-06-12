-- return {
-- 	{
-- 		"rose-pine/neovim",
-- 		name = "rose-pine",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			require("rose-pine").setup({
-- 				variant = "moon",
-- 				dark_variant = "moon",
-- 				extend_background_behind_borders = true,
-- 				styles = {
-- 					transparency = true,
-- 				},
-- 			})
--
-- 			vim.cmd.colorscheme("rose-pine")
--
-- 			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- 			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
-- 		end,
-- 	},
-- }
return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "moon", -- night, storm, moon, day
				-- transparent = true,
				styles = {
					comments = { italic = false },
					-- sidebars = "transparent",
					-- floats = "transparent",
				},
			})

			vim.cmd.colorscheme("tokyonight-moon")

			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
		end,
	},
}
