return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "[G]it [S]tatus" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "[G]it [C]ommit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "[G]it [P]ush" },
			{ "<leader>gP", "<cmd>Git pull --rebase<cr>", desc = "[G]it [P]ull rebase" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "[G]it [B]lame" },
			{ "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<cr>", desc = "[G]it [L]og" },
		},
		cmd = { "Git" },
	},
}
