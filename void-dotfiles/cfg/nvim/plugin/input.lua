--          ╔═════════════════════════════════════════════════════════╗
--          ║                           UI Input                      ║
--          ╚═════════════════════════════════════════════════════════╝
local M = {}
local icon = ' '
local au = function(event, pattern, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend('force', opts, {
      pattern = pattern,
    })
  )
end
local augroup = vim.api.nvim_create_augroup('custom-input', { clear = true })
M.state = {
  data = {
    buf_id = -1,
    win_id = -1,
  },
}

M.resize = function()
  if M.state.data.win_id == nil or not vim.api.nvim_win_is_valid(M.state.data.win_id) then return end
  local win_cfg = vim.api.nvim_win_get_config(M.state.data.win_id)
  local new_config = {
    relative = 'editor',
    width = win_cfg.width,
    col = math.floor((vim.o.columns - win_cfg.width) / 2),
    row = math.floor(vim.o.lines / 2),
  }
  vim.api.nvim_win_set_config(M.state.data.win_id, new_config)
end

M.float_input = function(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.5)
  local height = 1
  local buf = vim.api.nvim_create_buf(false, true)

  -- vim.api.nvim_exec_autocmds("User", { pattern = "UI-Input" })
  vim.bo[buf].filetype = 'UI-Input'
  local win_cfg = {
    title = { { icon, 'WarningMsg' }, { vim.trim(opts.prompt or 'Input') } },
    relative = 'editor',
    title_pos = 'left',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor(vim.o.lines / 2),
    style = 'minimal',
    border = 'double',
  }
  local win = vim.api.nvim_open_win(buf, true, win_cfg)
  M.state.data.win_id = win

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { opts.default or '' })

  return { buf_id = buf, win_id = win }
end
M.ui_input = function(opts, callback)
  if not vim.api.nvim_win_is_valid(M.state.data.win_id) then
    opts.buf_id = M.state.data.buf_id
    M.state.data = M.float_input(opts)
    vim.cmd('startinsert!')

    vim.keymap.set('i', '<CR>', function()
      local input = vim.trim(vim.api.nvim_buf_get_lines(M.state.data.buf_id, 0, 1, false)[1] or '')
      vim.api.nvim_win_close(M.state.data.win_id, true)
      vim.cmd('stopinsert!')
      callback(input)
    end, {
      buffer = M.state.data.buf_id,
      noremap = true,
      silent = true,
    })

    vim.keymap.set('i', '<Esc>', function()
      vim.api.nvim_win_close(M.state.data.win_id, true)
      vim.cmd('stopinsert!')
      callback(nil)
    end, {
      buffer = M.state.data.buf_id,
      noremap = true,
      silent = true,
    })
  else
    vim.api.nvim_win_hide(M.state.data.win_id)
  end
end

vim.ui.input = M.ui_input
au('VimResized', '*', {
  group = augroup,
  callback = M.resize,
})
