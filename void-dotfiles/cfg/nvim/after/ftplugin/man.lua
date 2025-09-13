if vim.bo.filetype ~= 'man' then
  return
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(event)
    if vim.bo.filetype == 'man' then
      vim.bo[event.buf].buflisted = false
      vim.api.nvim_exec2('wincmd L', {})
      vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = event.buf, silent = true })
    end
  end,
})
