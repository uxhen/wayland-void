-- Using `vim.cmd` instead of `vim.wo` because it is yet more reliable
vim.cmd('setlocal spell')
vim.cmd('setlocal wrap')

-- Customize 'mini.nvim'
local has_mini_ai, mini_ai = pcall(require, 'mini.ai')
if has_mini_ai then
  vim.b.miniai_config = {
    custom_textobjects = {
      ['*'] = mini_ai.gen_spec.pair('*', '*', { type = 'greedy' }),
      ['_'] = mini_ai.gen_spec.pair('_', '_', { type = 'greedy' }),
    },
  }
end

local has_mini_surround, mini_surround = pcall(require, 'mini.surround')
if has_mini_surround then
  vim.b.minisurround_config = {
    custom_surroundings = {
      -- Bold
      B = { input = { '%*%*().-()%*%*' }, output = { left = '**', right = '**' } },

      -- Link
      L = {
        input = { '%[().-()%]%(.-%)' },
        output = function()
          local link = mini_surround.user_input('Link: ')
          return { left = '[', right = '](' .. link .. ')' }
        end,
      },
    },
  }
end

-- search markdown links
local opts = { noremap = true, silent = true, buffer = 0 }
vim.keymap.set('n', '<C-l>', "<Cmd>call search('\\[[^]]*\\]([^)]\\+)')<CR>", opts)
vim.keymap.set('n', '<C-h>', "<Cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<CR>", opts)

-- close floating lsp hover window with Esc
if vim.api.nvim_win_get_config(0).relative == 'win' then
  vim.keymap.set('n', '<Esc>', '<Cmd>bdelete<CR>', { buffer = 0, silent = true })
end

-- save cursor position
vim.keymap.set('n', '<leader>t', function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local content = vim.api.nvim_get_current_line()
  local res = vim.fn.match(content, '\\[ \\]')
  if res == -1 then
    vim.fn.execute('.s/\\[[x~]\\]/[ ]')
  else
    vim.fn.execute('.s/\\[ \\]/[x]')
  end
  -- restore cursor position
  vim.api.nvim_win_set_cursor(0, cursor)
end, { buffer = 0, silent = true, desc = 'Toggle checkbox' })
vim.keymap.set('n', 'j', 'gj', { buffer = 0 })
vim.keymap.set('n', 'k', 'gk', { buffer = 0 })

-- Disable "show table of contents" built-in mapping (on Neovim>=0.11) in favor
-- of `gO` from 'mini.basics'
pcall(vim.keymap.del, 'n', 'gO', { buffer = 0 })
