return {
	{
		"nickjvandyke/opencode.nvim",
		tag = "v0.10.2",
		config = function()
			vim.g.opencode_opts = {}
			vim.o.autoread = true

			local oc = require("opencode")

			vim.keymap.set({ "n", "t" }, "<leader>oo", function()
				oc.toggle()
			end, { desc = "OpenCode: toggle panel" })

			vim.keymap.set({ "n", "x" }, "<leader>oe", function()
				return oc.operator("Explain @this", { submit = true })
			end, { expr = true, desc = "OpenCode: explain selection" })

			vim.keymap.set("n", "<leader>oee", function()
				return oc.operator("Explain @this", { submit = true }) .. "_"
			end, { expr = true, desc = "OpenCode: explain current line" })

			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				return oc.operator("@this ")
			end, { expr = true, desc = "OpenCode: add selection to prompt" })

			vim.keymap.set("n", "<leader>oaa", function()
				return oc.operator("@this ") .. "_"
			end, { expr = true, desc = "OpenCode: add current line to prompt" })

			vim.keymap.set({ "n", "x" }, "<leader>os", function()
				oc.select()
			end, { desc = "OpenCode: select action" })

			vim.keymap.set("n", "<leader>on", function()
				oc.command("session.new")
			end, { desc = "OpenCode: new session" })
		end,
	},
}
