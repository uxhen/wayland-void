--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Keybiding LSP                     ║
--          ╚═════════════════════════════════════════════════════════╝
-- Create keybindings, commands, inlay hints: ====================================================
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      -- Built In.Completion support: ============================================================
      -- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- -- Mini.Completion support: =============================================================
      vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
    end
    -- Enable Inlay hints:========================================================================
    -- if client ~= nil and client.server_capabilities.inlayHintProvider then
    -- 	vim.lsp.inlay_hint.enable(true)
    -- end
    -- Enable lsp folding per buffer, if supported: ==============================================
    -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- if client:supports_method('textDocument/foldingRange') then
    --   local win = vim.api.nvim_get_current_win()
    --   vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    -- end
    -- -- Enable Built In Completions: ===========================================================
    -- if client:supports_method("textDocument/completion", bufnr) then
    --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --   local chars = {}
    --   for i = 32, 126 do
    --     table.insert(chars, string.char(i))
    --   end
    --   client.server_capabilities.completionProvider.triggerCharacters = chars
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end
    -- -- Enable Built In Format: ================================================================
    -- if not client:supports_method('textDocument/willSaveWaitUntil')
    --     and client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end

    --- Disable semantic tokens: =================================================================
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    -- Disable the default keybinds: =============================================================
    for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr' }) do
      pcall(vim.keymap.del, 'n', bind)
    end

    -- All the keymaps: ==========================================================================
    -- stylua: ignore start
    local keymap = vim.keymap.set
    local lsp = vim.lsp
    local opts = { silent = true }
    local function opt(desc, others)
      return vim.tbl_extend('force', opts, { desc = desc }, others or {})
    end
    keymap('n', 'gd', lsp.buf.definition, opt('Go to definition'))
    keymap('n', 'gi', function() lsp.buf.implementation({ border = 'single' }) end, opt('Go to implementation'))
    keymap('n', 'gr', lsp.buf.references, opt('Show References'))
    keymap('n', 'gl', vim.diagnostic.open_float, opt('Open diagnostic in float'))
    keymap('n', '<leader>k', lsp.buf.signature_help, opts)
    -- disable the default binding first before using a custom one: ==============================
    pcall(vim.keymap.del, 'n', 'K', { buffer = ev.buf })
    keymap('n', 'K', function() lsp.buf.hover({ border = 'single', max_height = 30, max_width = 120 }) end,
      opt('Toggle hover'))
    keymap('n', '<Leader>lF', vim.cmd.FormatToggle, opt('Toggle AutoFormat'))
    keymap('n', '<Leader>lI', vim.cmd.Mason, opt('Mason'))
    keymap('n', '<Leader>lS', lsp.buf.workspace_symbol, opt('Workspace Symbols'))
    keymap('n', '<Leader>la', lsp.buf.code_action, opt('Code Action'))
    keymap('n', '<Leader>lh', function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
      opt('Toggle Inlayhints'))
    keymap('n', '<Leader>li', vim.cmd.LspInfo, opt('LspInfo'))
    keymap('n', '<Leader>ll', lsp.codelens.run, opt('Run CodeLens'))
    keymap('n', '<Leader>lr', lsp.buf.rename, opt('Rename'))
    keymap('n', '<Leader>ls', lsp.buf.document_symbol, opt('Doument Symbols'))
    -- diagnostic mappings: ======================================================================
    keymap('n', '<Leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, opt('Next Diagnostic'))
    keymap('n', '<Leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, opt('Prev Diagnostic'))
    keymap('n', '<leader>df',
      function()
        vim.diagnostic.open_float(nil,
          {
            focusable = false,
            border = 'double',
            source = 'always',
            header = 'Diagnostics',
            prefix = '● ',
            scope =
            'cursor',
          })
      end)
    keymap('n', '<Leader>dq', vim.diagnostic.setloclist, opt('Set LocList'))
    keymap('n', '<leader>gq', vim.diagnostic.setqflist)
    keymap('n', '<Leader>dv', function()
      vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end, opt('Toggle diagnostic virtual_lines'))
  end,
})

-- Add notification to lsp rename: ===============================================================
local originalRenameHandler = vim.lsp.handlers['textDocument/rename']
vim.lsp.handlers['textDocument/rename'] = function(err, result, ctx, config)
  originalRenameHandler(err, result, ctx, config)
  if err or not result then return end

  -- count changes
  local changes = result.changes or result.documentChanges or {}
  local changedFiles = vim.iter(vim.tbl_keys(changes))
      :filter(function(file) return #changes[file] > 0 end)
      :map(function(file) return '- ' .. vim.fs.basename(file) end)
      :totable()
  local changeCount = vim.iter(changes)
      :fold(0, function(sum, _, change) return sum + #(change.edits or change) end)

  -- notification
  local pluralS = changeCount > 1 and 's' or ''
  local msg = ('[%d] instance%s'):format(changeCount, pluralS)
  if #changedFiles > 1 then
    local fileList = table.concat(changedFiles, '\n')
    msg = ('**%s in [%d] files**\n%s'):format(msg, #changedFiles, fileList)
  end
  vim.notify(msg, nil, { title = 'Renamed with LSP', icon = '󰑕' })

  -- save all
  if #changedFiles > 1 then vim.cmd('silent! wall') end
end

--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Command LSP                       ║
--          ╚═════════════════════════════════════════════════════════╝
-- Start, Stop, Restart, Log commands: ===========================================================
vim.api.nvim_create_user_command('LspStart', function()
  vim.cmd.e()
end, { desc = 'Starts LSP clients in the current buffer' })

vim.api.nvim_create_user_command('LspStop', function(opts)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if opts.args == '' or opts.args == client.name then
      client:stop(true)
      vim.notify(client.name .. ': stopped')
    end
  end
end, {
  desc = 'Stop all LSP clients or a specific client attached to the current buffer.',
  nargs = '?',
  complete = function(_, _, _)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    return client_names
  end,
})

vim.api.nvim_create_user_command('LspRestart', function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop(true)
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  if not timer then
    return vim.notify('Servers are stopped but havent been restarted')
  end
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start(client[1].config, { attach = false })
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ': restarted')
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = 'Restart all the language client(s) attached to the current buffer',
})

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
  desc = 'Get all the lsp logs',
})

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd('silent checkhealth vim.lsp')
end, {
  desc = 'Get all the information about all LSP attached',
})

vim.lsp.set_log_level('ERROR')
local function refresh()
  vim.lsp.stop_client(vim.lsp.get_clients(), true)
  vim.defer_fn(
    function()
      local window_buffer_map = {}
      for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buffer_id = vim.api.nvim_win_get_buf(window_id)
        table.insert(window_buffer_map, {
          window_id = window_id, buffer_id = buffer_id
        })
      end

      if #window_buffer_map > 0 then
        vim.cmd('bufdo if &modifiable | write | edit | endif')
      end

      for _, entry in pairs(window_buffer_map) do
        vim.api.nvim_win_set_buf(entry.window_id, entry.buffer_id)
      end
    end,
    100
  )
end
vim.keymap.set('n', 'gn', refresh)
