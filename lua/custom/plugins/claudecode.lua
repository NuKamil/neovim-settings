vim.pack.add { 'https://github.com/coder/claudecode.nvim' }
require('claudecode').setup {}

local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc }) end

map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', 'Claude: toggle')
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', 'Claude: focus')
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', 'Claude: resume session')
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', 'Claude: add current buffer')
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', 'Claude: send selection')
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', 'Claude: accept diff')
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', 'Claude: deny diff')
