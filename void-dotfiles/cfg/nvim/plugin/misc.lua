--          ╔═════════════════════════════════════════════════════════╗
--          ║                         Misc                            ║
--          ╚═════════════════════════════════════════════════════════╝
local M = {}
-- Open url in buffer: ===========================================================================
function M.openUrlInBuffer()
  local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  local urls = {}
  for url in text:gmatch([[%l%l%l+://[^%s)%]}"'`>]+]]) do
    urls[#urls + 1] = url
  end
  if #urls == 0 then
    return vim.notify('No URL found in file.', vim.log.levels.WARN)
  elseif #urls == 1 then
    return vim.ui.open(urls[1])
  end
  vim.ui.select(urls, { prompt = ' Open URL:' }, function(url)
    if url then vim.ui.open(url) end
  end)
end

vim.api.nvim_create_user_command('OpenUrlInBuffer', M.openUrlInBuffer, {})
-- Toggle word: ==================================================================================
function M.toggleWord()
  local toggles = {
    ['useState(true)'] = 'useState(false)',
    ['relative'] = 'absolute',
    ['active'] = 'inactive',
    ['enable'] = 'disable',
    ['visible'] = 'hidden',
    ['success'] = 'error',
    ['always'] = 'never',
    ['left'] = 'right',
    ['top'] = 'bottom',
    ['true'] = 'false',
    ['True'] = 'False',
    ['allow'] = 'deny',
    ['light'] = 'dark',
    ['show'] = 'hide',
    ['let'] = 'const',
    ['up'] = 'down',
    ['yes'] = 'no',
  }
  local cword = vim.fn.expand('<cword>')
  local newWord
  for word, opposite in pairs(toggles) do
    if cword == word then newWord = opposite end
    if cword == opposite then newWord = word end
  end
  if newWord then
    local prevCursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd.normal { '"_ciw' .. newWord, bang = true }
    vim.api.nvim_win_set_cursor(0, prevCursor)
  end
end

vim.api.nvim_create_user_command('ToggleWorld', M.toggleWord, {})
-- Smart duplicate line: =========================================================================
function M.smartDuplicate()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local ft = vim.bo.filetype
  -- FILETYPE-SPECIFIC TWEAKS
  if ft == 'css' then
    local newLine = line
    if line:find('top:') then newLine = line:gsub('top:', 'bottom:') end
    if line:find('bottom:') then newLine = line:gsub('bottom:', 'top:') end
    if line:find('right:') then newLine = line:gsub('right:', 'left:') end
    if line:find('left:') then newLine = line:gsub('left:', 'right:') end
    line = newLine
  elseif ft == 'javascript' or ft == 'typescript' or ft == 'swift' then
    line = line:gsub('^(%s*)if(.+{)$', '%1} else if%2')
  elseif ft == 'lua' then
    line = line:gsub('^(%s*)if( .* then)$', '%1elseif%2')
  elseif ft == 'zsh' or ft == 'bash' then
    line = line:gsub('^(%s*)if( .* then)$', '%1elif%2')
  elseif ft == 'python' then
    line = line:gsub('^(%s*)if( .*:)$', '%1elif%2')
  end
  -- INSERT DUPLICATED LINE
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
  -- MOVE CURSOR DOWN, AND TO VALUE/FIELD (IF THERE IS ANY)
  local _, luadocFieldPos = line:find('%-%-%-@%w+ ')
  local _, valuePos = line:find('[:=] ')
  local targetCol = luadocFieldPos or valuePos or col
  vim.api.nvim_win_set_cursor(0, { row + 1, targetCol })
end

vim.api.nvim_create_user_command('SmartDuplicate', M.smartDuplicate, {})
-- lspCapabilities: ==============================================================================
function M.lspCapabilities()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    vim.notify('No LSPs attached.', vim.log.levels.WARN, { icon = '󱈄' })
    return
  end
  vim.ui.select(clients, {
    prompt = '󱈄 Select LSP:',
    format_item = function(client) return client.name end,
  }, function(client)
    if not client then return end
    local info = {
      capabilities = client.capabilities,
      server_capabilities = client.server_capabilities,
      config = client.config,
    }
    local opts = { icon = '󱈄', title = client.name .. ' capabilities', ft = 'lua' }
    local header = '-- For a full view, open in notification history.\n'
    vim.notify(header .. vim.inspect(info), vim.log.levels.INFO, opts)
  end)
end

vim.api.nvim_create_user_command('LspCapabilities', M.lspCapabilities, {})
-- Capabilities: =================================================================================
function M.toggleTitleCase()
  local prevCursor = vim.api.nvim_win_get_cursor(0)
  local cword = vim.fn.expand('<cword>')
  local cmd = cword == cword:lower() and 'guiwgUl' or 'guiw'
  vim.cmd.normal { cmd, bang = true }
  vim.api.nvim_win_set_cursor(0, prevCursor)
end

vim.api.nvim_create_user_command('ToggleTitleCase', M.toggleTitleCase, {})
-- Delete buff: ==================================================================================
local winclose = function() vim.cmd.wincmd({ args = { 'c' } }) end
local tab_win_bufnrs = function(tabnr)
  local tab_wins = vim.tbl_filter(function(win)
    local win_buf = vim.api.nvim_win_get_buf(win)
    if 1 ~= vim.fn.buflisted(win_buf) then return true end
    return true
  end, vim.api.nvim_tabpage_list_wins(tabnr))
  return tab_wins
end
local loaded_bufnrs = function()
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then return false end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if not vim.api.nvim_buf_is_loaded(b) then return false end
    return true
  end, vim.api.nvim_list_bufs())
  return bufnrs
end
M.delete_buffer = function()
  local tabnr = vim.api.nvim_get_current_tabpage()
  local bufnr = vim.api.nvim_get_current_buf()
  local num_tabs = #vim.api.nvim_list_tabpages()
  local bufs = loaded_bufnrs()
  local tab_wins = tab_win_bufnrs(tabnr)

  if #tab_wins > 1 then
    winclose()
  elseif num_tabs > 1 then
    if bufs[1] == bufnr then
      vim.cmd.tabclose()
    else
      winclose()
    end
  elseif #bufs <= 1 then
    if bufs[1] == bufnr then
      vim.cmd.quitall()
    else
      winclose()
    end
  else
    require('mini.bufremove').delete()
  end
end
vim.api.nvim_create_user_command('DeleteBuffer', M.delete_buffer, {})
-- Delete others buff: ============================================================================
function M.deleteOthersBuffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= vim.fn.bufnr() and vim.fn.buflisted(buf) == 1 then
      require('mini.bufremove').delete(buf, true)
    end
  end
end

vim.api.nvim_create_user_command('DeleteOtherBuffers', M.deleteOthersBuffers, {})
