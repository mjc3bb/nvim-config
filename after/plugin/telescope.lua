local builtin = require('telescope.builtin')
local tabs = require('telescope-tabs')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pF', function() builtin.find_files( {no_ignore=true}) end)
vim.keymap.set('n', '<leader>pt', function() tabs.list_tabs() end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>pS', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") , no_ignore=true })
end)


