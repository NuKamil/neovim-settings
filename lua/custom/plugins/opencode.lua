return {
  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    config = function()
      vim.g.opencode_opts = {}

      local oc = require 'opencode'

      vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
        oc.toggle()
      end, { desc = 'OpenCode: toggle' })

      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        oc.ask('@this: ', { submit = true })
      end, { desc = 'OpenCode: ask @this' })

      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        oc.select()
      end, { desc = 'OpenCode: select' })

      vim.keymap.set('n', '<leader>on', function()
        oc.command 'session.new'
      end, { desc = 'OpenCode: new session' })
    end,
  },
}
