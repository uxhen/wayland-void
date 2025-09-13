--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Statusline                        ║
--          ╚═════════════════════════════════════════════════════════╝
local M = {}
local LSP_KIND_TO_ICON = {
  File = '',
  Module = '',
  Namespace = '',
  Package = '',
  Class = '',
  Method = '',
  Property = '',
  Field = '',
  Constructor = '',
  Enum = '',
  Interface = '',
  Function = '',
  Variable = '',
  Constant = '',
  String = '',
  Number = '',
  Boolean = '',
  Array = '',
  Object = '',
  Key = '',
  Null = '',
  EnumMember = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}
local KIND_NUM_TO_NAME = {}
for name, id in pairs(vim.lsp.protocol.SymbolKind) do
  KIND_NUM_TO_NAME[id] = name
end
-- Helpers: =======================================================================================
local hi_next = function(group)
  return '%#' .. group .. '#'
end
local function debounce(func, timeout)
  local timer = vim.loop.new_timer()
  return function()
    if timer then
      timer:start(timeout, 0, function()
        timer:stop()
        vim.schedule(func)
      end)
    end
  end
end
-- Mode: ==========================================================================================
local modes = {
  ['n']      = 'NOR',
  ['no']     = 'OPR',
  ['nov']    = 'OPR',
  ['noV']    = 'OPL',
  ['no\x16'] = 'VOB',
  ['\x16']   = 'VBL',
  ['niI']    = 'INS',
  ['niR']    = 'REP',
  ['niV']    = 'RVI',
  ['nt']     = 'TER',
  ['ntT']    = 'TER',
  ['v']      = 'VIS',
  ['vs']     = 'VIS',
  ['V']      = 'VSL',
  ['Vs']     = 'VSL',
  ['\x16s']  = 'VBL',
  ['s']      = 'SEL',
  ['S']      = 'SLL',
  ['\x13']   = 'SBL',
  ['i']      = 'INS',
  ['ic']     = 'ICO',
  ['ix']     = 'ICX',
  ['R']      = 'REP',
  ['Rc']     = 'RCO',
  ['Rx']     = 'RVX',
  ['Rv']     = 'RVI',
  ['Rvc']    = 'RVC',
  ['Rvx']    = 'RVX',
  ['c']      = 'CMO',
  ['cv']     = 'EXM',
  ['r']      = 'PRO',
  ['rm']     = 'MOR',
  ['r?']     = 'CFM',
  ['!']      = 'SHL',
  ['t']      = 'TRM',
}
function M.mode()
  local mode = vim.fn.mode()
  local mode_str = modes[mode]
  vim.b.statusline_mode = ('   %s  '):format(mode_str)
end

-- filetype :======================================================================================
local ft_to_cat = {
  javascript = 'WEB',
  typescript = 'WEB',
  html = 'WEB',
  css = 'WEB',
  scss = 'WEB',
  sass = 'WEB',
  less = 'WEB',
  vue = 'WEB',
  jsx = 'WEB',
  tsx = 'WEB',
  markdown = 'WEB',
  md = 'WEB',
  lua = 'ENV',
  conf = 'ENV',
  ini = 'ENV',
  vim = 'ENV',
  zsh = 'ENV',
  dockerfile = 'ENV',
  makefile = 'ENV',
  cmake = 'ENV',
  csv = 'DAT',
  xml = 'DAT',
  json = 'DAT',
  yaml = 'DAT',
  toml = 'DAT',
  hcl = 'DAT',
  sh = 'SYS',
  bash = 'SYS',
  fish = 'SYS',
  powershell = 'SYS',
  sql = 'DAB',
  mysql = 'DAB',
  plsql = 'DAB',
  postgresql = 'DAB',
  terminal = 'TER',
  toggleterm = 'TER',
  floaterm = 'TER',
  gitcommit = 'GIT',
  gitrebase = 'GIT',
  gitconfig = 'GIT',
  ministarter = 'WEL',
  dashboard = 'WEL',
  alpha = 'WEL',
  minipick = 'PLG',
  minifiles = 'PLG'
}
function M.ft_cat()
  local ft = vim.bo.filetype:lower()
  local cat = ft_to_cat[ft]
  local label = cat and cat or ft:upper()
  vim.b.ft_cat = ('  %s  '):format(label)
end

-- LSP: ===========================================================================================
M.lsp_update_status = debounce(function()
  ---@type table<string, string>
  local lsp_status_by_client = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    for progress in client.progress do
      local msg = progress.value
      if type(msg) == 'table' and msg.kind ~= 'end' then
        local percentage = ''
        if msg.percentage then
          percentage = string.format('%2d', msg.percentage) .. '% '
        end
        local title = msg.title or ''
        local message = msg.message or ''
        lsp_status_by_client[client.name] = percentage .. title .. ' ' .. message
      else
        lsp_status_by_client[client.name] = nil
      end
    end
  end

  local items = {}
  for k, v in pairs(lsp_status_by_client) do
    table.insert(items, ' ' .. k .. ': ' .. v)
  end

  vim.g.lsp_status = table.concat(items, ' │ ')
  vim.cmd.redrawstatus()
end, 50)
vim.g.lsp_status = ''
vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave', 'WinScrolled', 'BufWinEnter' }, {
  pattern = { '*' },
  callback = debounce(function()
    local bufnr = vim.api.nvim_get_current_buf()
    if #vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/documentSymbol' }) == 0 then
      vim.b[bufnr].lsp_location = ''
      vim.cmd.redrawstatus()
      return
    end
    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', params, function(err, result)
      if err or not result then
        vim.b[bufnr].lsp_location = ''
        vim.cmd.redrawstatus()
        return
      end
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      local cursor_line = cursor_pos[1] - 1 -- Convert to 0-based index
      local cursor_col = cursor_pos[2]      -- 0 based
      ---@type string[]
      local named_symbols = {}
      -- Recursively traverses symbols
      -- Gets the named nodes surrounding current cursor
      ---@param symbols lsp.DocumentSymbol[]
      local function process_symbols(symbols)
        for _, symbol in ipairs(symbols) do
          local range = symbol.range or symbol.location.range
          if
              (
                range.start.line < cursor_line
                or (
                  range.start.line == cursor_line
                  and range.start.character <= cursor_col
                )
              )
              and (
                range['end'].line > cursor_line
                or (
                  range['end'].line == cursor_line
                  and range['end'].character >= cursor_col
                )
              )
          then
            local kind_name = KIND_NUM_TO_NAME[symbol.kind] or 'File'
            local icon = LSP_KIND_TO_ICON[kind_name] or ''
            table.insert(named_symbols, icon .. ' ' .. symbol.name)
            if symbol.children then
              process_symbols(symbol.children)
            end
            break
          end
        end
      end
      process_symbols(result)
      vim.b[bufnr].lsp_location = (' %s'):format(table.concat(named_symbols, '  '))
      vim.cmd.redrawstatus()
    end)
  end, 50),
  desc = 'Update lsp symbols for status line',
})
-- Setup:  ========================================================================================
function M.setup()
  if not vim.diagnostic.status then
    vim.diagnostic.status = function()
      local counts = vim.diagnostic.count(0)
      local user_signs = vim.tbl_get(
        vim.diagnostic.config() --[[@as vim.diagnostic.Opts]],
        'signs',
        'text'
      ) or {}
      local signs = vim.tbl_extend('keep', user_signs, { 'E', 'W', 'I', 'H' })
      local result_str = vim.iter(pairs(counts))
          :map(function(severity, count)
            return ('%s %d'):format(signs[severity], count)
          end)
          :join(' ')

      return result_str
    end
  end
  vim.opt.statusline = table.concat({
    hi_next('StatusLineHeader'),
    '%(%{get(b:, "statusline_mode", "")} %)',
    '%<',
    hi_next('StatusLineLsp'),
    '%(%{get(b:, "lsp_location", "")} %)',
    '%(%{get(g:, "lsp_status")} %)',
    '%= ',
    '%(%{v:lua.vim.diagnostic.status()} │ %)',
    '%(%{get(b:, "minidiff_summary_string", "")} %)',
    hi_next('StatusLineFooter'),
    '%{get(b:, "ft_cat", "")}',
  }, '')
  vim.api.nvim_create_autocmd({ 'UIEnter', 'BufEnter' }, {
    pattern = '*',
    desc = 'Refresh statusline Filetype Category',
    callback = M.ft_cat
  })
  vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufEnter' }, {
    pattern = '*',
    desc = 'Refresh statusline Mode',
    callback = M.mode
  })
  vim.api.nvim_create_autocmd('LspProgress', {
    pattern = '*',
    desc = 'Refresh statusline on LspProgress',
    callback = M.lsp_update_status,
  })
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    pattern = '*',
    desc = 'Refresh statusline on DiagnosticChanged',
    callback = debounce(function()
      vim.cmd.redrawstatus()
    end, 30),
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniDiffUpdated',
    desc = 'Do not print changed lines, only added and removed',
    callback = function(data)
      local summary = vim.b[data.buf].minidiff_summary or {}
      local t = {
        add = (summary.add or 0) + (summary.change or 0),
        delete = (summary.delete or 0) + (summary.change or 0),
      }
      local res = {}
      if t.add > 0 then
        table.insert(res, '+' .. t.add)
      end
      if t.delete > 0 then
        table.insert(res, '-' .. t.delete)
      end
      vim.b[data.buf].minidiff_summary_string = table.concat(res, ' ')
    end,
  })
end

-- Call ===========================================================================================
return M
