vim.g.mapleader = " ";
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex);

vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv");
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv");

vim.keymap.set("n", "<leader>y", "\"+y");
vim.keymap.set("v", "<leader>y", "\"+y");
vim.keymap.set("n", "<leader>Y", "\"+Y");

vim.keymap.set("n", "<leader>p", "\"+p");
vim.keymap.set("v", "<leader>p", "\"+p");
vim.keymap.set("n", "<leader>p", "\"+p");


vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>");

-- quick fix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz");
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz");
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz");
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz");


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true });
