--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Smart Enter                       ║
--          ╚═════════════════════════════════════════════════════════╝
-- Pre-resolved termcodes for efficiency: ========================================================
local cr_default = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
local esc_O = vim.api.nvim_replace_termcodes('<CR><Esc>O', true, true, true)
local ctrl_y = vim.api.nvim_replace_termcodes('<C-y>', true, true, true)

-- Cache the mini.pairs.cr function (no need to require every time):==============================
local mini_pairs_cr
pcall(function()
  mini_pairs_cr = require('mini.pairs').cr
end)

-- Smart Enter function: =========================================================================
local function smart_enter()
  -- Fast path: Handle completion menu selection first (avoid unnecessary work)
  if vim.fn.pumvisible() == 1 then
    local selected = vim.fn.complete_info({ 'selected' }).selected
    if selected ~= -1 then
      return ctrl_y
    end
  end

  -- Only get line and column if needed
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- col() is 1-based
  local line = vim.api.nvim_get_current_line()
  local line_len = #line

  -- Check for '><' pattern
  if col > 1 and col <= line_len then
    local prev_byte = line:byte(col - 1)
    local next_byte = line:byte(col)
    if prev_byte == 62 and next_byte == 60 then
      return esc_O
    end
  end

  -- Fallback to mini.pairs or default <CR>
  return mini_pairs_cr and mini_pairs_cr() or cr_default
end

-- Fast filetype lookup table: ===================================================================
local filetypes = {
  html = true,
  xml = true,
  jsx = true,
  tsx = true,
  typescriptreact = true,
  javascriptreact = true,
  vue = true,
  svelte = true,
}

-- Autocmd to set up smart enter mapping per relevant filetype: ==================================
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if filetypes[ft] then
      vim.keymap.set('i', '<CR>', smart_enter, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        expr = true,
        desc = 'Smart Enter',
      })
    end
  end,
})
