vim.o.relativenumber = true

vim.keymap.set('v', 'J', ":move '>+1<CR>gv=gv", {
  desc = 'Przesuń zaznaczenie w dół',
})

vim.keymap.set('v', 'K', ":move '<-2<CR>gv=gv", {
  desc = 'Przesuń zaznaczenie w górę',
})
