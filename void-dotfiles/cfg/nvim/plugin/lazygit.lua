--          ╔═════════════════════════════════════════════════════════╗
--          ║                     Toggle Lazygit                      ║
--          ╚═════════════════════════════════════════════════════════╝
local group = vim.api.nvim_create_augroup('LazygitClose', { clear = true })
vim.api.nvim_create_autocmd('TermClose', {
  group = group,
  pattern = { 'term://*' },
  callback = function()
    vim.api.nvim_input('<CR>')
  end,
})

vim.keymap.set('n', '<leader>gg', function()
  if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
    vim.cmd('vs')
  else
    vim.cmd('split')
  end
  vim.cmd('terminal lazygit')
  vim.cmd('startinsert')
end, { desc = 'Lazygit' })
