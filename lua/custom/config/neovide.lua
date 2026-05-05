local M = {}

local function apply_neovide_settings()
	if not vim.g.neovide then
		return
	end

	vim.o.guifont = "MesloLGM Nerd Font Mono:h13"

	vim.g.neovide_opacity = 0.92
	vim.g.neovide_normal_opacity = 0.92
	vim.g.neovide_scale_factor = 1.0

	vim.g.neovide_padding_top = 6
	vim.g.neovide_padding_bottom = 6
	vim.g.neovide_padding_left = 6
	vim.g.neovide_padding_right = 6

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set({ "n", "i", "v" }, "<C-=>", function()
		change_scale_factor(1.25)
	end, { desc = "Neovide zoom in" })

	vim.keymap.set({ "n", "i", "v" }, "<C-->", function()
		change_scale_factor(1 / 1.25)
	end, { desc = "Neovide zoom out" })

	vim.keymap.set({ "n", "i", "v" }, "<C-0>", function()
		vim.g.neovide_scale_factor = 1.0
	end, { desc = "Neovide zoom reset" })
end

function M.setup()
	apply_neovide_settings()

	vim.api.nvim_create_autocmd("UIEnter", {
		callback = function()
			vim.schedule(apply_neovide_settings)
		end,
	})
end

return M
