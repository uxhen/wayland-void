--              ╔═════════════════════════════════════════════════════════╗
--              ║                          Plugins                        ║
--              ╚═════════════════════════════════════════════════════════╝
--              ┌─────────────────────────────────────────────────────────┐
--                    Clone 'mini.nvim manually in a way that it gets
--                                managed by 'mini.deps'
--              └─────────────────────────────────────────────────────────┘
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Deps                           │
--              ╰─────────────────────────────────────────────────────────╯
require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Git                            │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  require('mini.git').setup()
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Diff                           │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  require('mini.diff').setup({ view = { style = 'sign' } })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Notify                         │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local MiniNotify = require('mini.notify')
  MiniNotify.setup({
    lsp_progress = { enable = false, duration_last = 500 },
    window = {
      config = function()
        local has_statusline = vim.o.laststatus > 0
        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
      end,
      max_width_share = 0.45,
    },
  })
  vim.notify = MiniNotify.make_notify()
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Hipatterns                     │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local MiniHiPatterns = require('mini.hipatterns')
  MiniHiPatterns.setup({
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
      hex_color = require('mini.hipatterns').gen_highlighter.hex_color({
        style = 'full',
        inline_text = ' ',
        priority = 200,
      }),
      hex_shorthand = {
        pattern = '()#%x%x%x()%f[^%x%w]',
        group = function(_, _, data)
          local match = data.full_match
          local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
          local hex_color = '#' .. r .. r .. g .. g .. b .. b
          return MiniHiPatterns.compute_hex_color_group(hex_color, 'bg')
        end,
      },
      hsl_color = {
        pattern = 'hsl%(%d+, ?%d+%%, ?%d+%%%)',
        group = function(_, match)
          local hue, saturation, lightness = match:match('hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)')
          local function hsl_to_rgb(h, s, l)
            h, s, l = h % 360, s / 100, l / 100
            if h < 0 then h = h + 360 end
            local function f(n)
              local k = (n + h / 30) % 12
              local a = s * math.min(l, 1 - l)
              return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
            end
            return f(0) * 255, f(8) * 255, f(4) * 255
          end
          local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
          local hex = string.format('#%02x%02x%02x', red, green, blue)
          return MiniHiPatterns.compute_hex_color_group(hex, 'bg')
        end
      },
    },
  })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Pairs                          │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local MiniPairs = require('mini.pairs')
  MiniPairs.setup({
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
    modes = { insert = true, command = true, terminal = true },
    mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][%s%)%]%}]' },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][%s%)%]%}]' },
      ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][%s%)%]%}]' },
      [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
      [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
      ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
      ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w][^%w]', register = { cr = false } },
      ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w][^%w]', register = { cr = false } },
      ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w][^%w]', register = { cr = false } },
      ['<'] = { action = 'closeopen', pair = '<>', neigh_pattern = '[^%S][^%S]', register = { cr = false } },
    },
  })
  local cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and '\25' or '\25\r'
    else
      return MiniPairs.cr()
    end
  end
  vim.keymap.set('i', '<cr>', cr_action, { expr = true })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                         Mini.Ai                         │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local MiniAi = require('mini.ai')
  local MiniExtra = require('mini.extra')
  local gen_ai_spec = MiniExtra.gen_ai_spec
  MiniExtra.setup()
  MiniAi.setup({
    n_lines = 500,
    search_method = 'cover_or_nearest',
    mappings = {
      around = 'a',
      inside = 'i',
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',
      goto_left = '{',
      goto_right = '}',
    },
    custom_textobjects = {
      r = gen_ai_spec.diagnostic(),
      a = gen_ai_spec.buffer(),
      i = gen_ai_spec.indent(),
      d = gen_ai_spec.number(),
      c = gen_ai_spec.line(),
      e = {
        {
          -- __-1, __-U, __-l, __-1_, __-U_, __-l_
          '[^_%-]()[_%-]+()%w()()[%s%p]',
          '^()[_%-]+()%w()()[%s%p]',
          -- __-123SNAKE
          '[^_%-]()[_%-]+()%d+%u[%u%d]+()()',
          '^()[_%-]+()%d+%u[%u%d]+()()',
          -- __-123snake
          '[^_%-]()[_%-]+()%d+%l[%l%d]+()()',
          '^()[_%-]+()%d+%l[%l%d]+()()',
          -- __-SNAKE, __-SNAKE123
          '[^_%-]()[_%-]+()%u[%u%d]+()()',
          '^()[_%-]+()%u[%u%d]+()()',
          -- __-snake, __-Snake, __-snake123, __-Snake123
          '[^_%-]()[_%-]+()%a[%l%d]+()()',
          '^()[_%-]+()%a[%l%d]+()()',
          -- UPPER, UPPER123, UPPER-__, UPPER123-__
          -- No support: 123UPPER
          '[^_%-%u]()()%u[%u%d]+()[_%-]*()',
          '^()()%u[%u%d]+()[_%-]*()',
          -- UPlower, UPlower123, UPlower-__, UPlower123-__
          '%u%u()()[%l%d]+()[_%-]*()',
          -- lower, lower123, lower-__, lower123-__
          '[^_%-%w]()()[%l%d]+()[_%-]*()',
          '^()()[%l%d]+()[_%-]*()',
          -- Camel, Camel123, Camel-__, Camel123-__
          '[^_%-%u]()()%u[%l%d]+()[_%-]*()',
          '^()()%u[%l%d]+()[_%-]*()',
        },
      },
    },
  })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Surround                       │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  require('mini.surround').setup({
    n_lines = 500,
    custom_surroundings = {
      ['('] = { output = { left = '(', right = ')' } },
      ['['] = { output = { left = '[', right = ']' } },
      ['{'] = { output = { left = '{', right = '}' } },
      ['<'] = { output = { left = '<', right = '>' } },
    },
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = 'sf',
      find_left = 'sF',
      highlight = 'sh',
      replace = 'cs',
      update_n_lines = 'sn',
      suffix_last = 'l',
      suffix_next = 'n',
    },
  })
  -- custom quotes surrounding rotation for quick access: ========================================
  local function SurroundOrReplaceQuotes()
    local word = vim.fn.expand('<cword>')
    local row, old_pos = unpack(vim.api.nvim_win_get_cursor(0))
    vim.fn.search(word, 'bc', row)
    local _, word_pos = unpack(vim.api.nvim_win_get_cursor(0))
    local line_str = vim.api.nvim_get_current_line()
    local before_word = line_str:sub(0, word_pos)
    local pairs_count = 0
    for _ in before_word:gmatch('["\'`]') do
      pairs_count = pairs_count + 1
    end
    if pairs_count % 2 == 0 then
      vim.cmd('normal ysiw\"')
      vim.api.nvim_win_set_cursor(0, { row, old_pos + 1 })
      return
    end
    for i = #before_word, 1, -1 do
      local char = before_word:sub(i, i)
      if char == "'" then
        vim.cmd("normal cs'\"")
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
      if char == '"' then
        vim.cmd('normal cs\"`')
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
      if char == '`' then
        vim.cmd("normal cs`'")
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
    end
  end
  vim.keymap.set({ 'n' }, 'sq', SurroundOrReplaceQuotes)
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Pick                           │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local MiniPick = require('mini.pick')
  MiniPick.setup({
    mappings = {
      choose           = '<Tab>',
      move_down        = '<C-j>',
      move_up          = '<C-k>',
      toggle_preview   = '<C-p>',
      choose_in_split  = '<C-v>',
      choose_in_vsplit = '<C-s>',
    },
    options = {
      use_cache = true,
      content_from_bottom = false
    },
    window = {
      config = {
        height = vim.o.lines,
        width = vim.o.columns,
      },
      prompt_caret = '|',
      prompt_prefix = '󱓇 ',
    },
  })
  vim.ui.select = MiniPick.ui_select
  -- UI: =========================================================================================
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniPickStart",
    callback = function()
       local win_id = vim.api.nvim_get_current_win()
       vim.wo[win_id].winblend = 15
    end,
  })
  -- Pick Directory  Form Zoxide : ===============================================================
  local function zoxide_pick()
    local zoxide_output = vim.fn.systemlist('zoxide query -ls')
    local directories = {}
    for _, line in ipairs(zoxide_output) do
      local path = line:match('%d+%.%d+%s+(.*)')
      if path then
        table.insert(directories, path)
      end
    end
    MiniPick.start({
      source = {
        items = directories,
        name = 'Directories (zoxide)',
        choose = function(item)
          vim.schedule(function()
            vim.fn.chdir(item)
            require('mini.files').open(item)
          end)
        end,
      },
    })
  end
  vim.keymap.set('n', '<leader>fd', zoxide_pick)
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Completion                     │
--              ╰─────────────────────────────────────────────────────────╯
now(function()
  -- enable Mini.Completion: =====================================================================
  local MiniCompletion = require('mini.completion')
  MiniCompletion.setup({
    delay = { completion = 50, info = 40, signature = 30 },
    window = {
      info = { border = 'single' },
      signature = { border = 'single' },
    },
    mappings = {
      force_twostep = '<C-n>',
      force_fallback = '<C-S-n>',
      scroll_down = '<C-f>',
      scroll_up = '<C-b>',
    },
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        return require('mini.completion').default_process_items(items, base, {
          filtersort = 'fuzzy',
          kind_priority = {
            Text = -1,
            Snippet = 99,
          },
        })
      end,
    },
  })
  -- enable configured language servers 0.11: ====================================================
  local lsp_configs = { 'lua', 'html', 'css', 'emmet', 'json', 'tailwind', 'typescript', 'eslint', 'prisma' }
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, MiniCompletion.get_lsp_capabilities())
  vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = {
      '.git'
    },
  })
  for _, config in ipairs(lsp_configs) do
    vim.lsp.enable(config)
  end
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Snippets                       │
--              ╰─────────────────────────────────────────────────────────╯
now(function()
  local MiniSnippets    = require('mini.snippets')
  -- Languge Patterns: ===========================================================================
  local markdown        = { 'markdown.json' }
  local webHtmlPatterns = { 'html.json', 'ejs.json' }
  local webJsTsPatterns = { 'web/javascript.json' }
  local webPatterns     = { 'web/*.json' }
  local lang_patterns   = {
    markdown_inline = markdown,
    html = webHtmlPatterns,
    ejs = webHtmlPatterns,
    tsx = webPatterns,
    javascriptreact = webPatterns,
    typescriptreact = webPatterns,
    javascript = webJsTsPatterns,
    typescript = webJsTsPatterns,
  }
  -- Expand Patterns: ============================================================================
  local match_strict    = function(snips)
    -- Do not match with whitespace to cursor's left =============================================
    -- return require('mini.snippets').default_match(snips, { pattern_fuzzy = '%S+' })
    -- Match exact from the start to the end of the string =======================================
    return MiniSnippets.default_match(snips, { pattern_fuzzy = '^%S+$' })
  end
  -- Setup Snippets ==============================================================================
  MiniSnippets.setup({
    snippets = {
      require('mini.snippets').gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      require('mini.snippets').gen_loader.from_lang({ lang_patterns = lang_patterns })
    },
    mappings = {
      expand = '<C-e>',
      jump_next = '<C-l>',
      jump_prev = '<C-h>',
      stop = '<C-c>',
    },
    expand   = {
      match = match_strict,
      insert = function(snippet)
        return MiniSnippets.default_insert(snippet, {
          empty_tabstop = '',
          empty_tabstop_final = '†'
        })
      end
    },
  })
  MiniSnippets.start_lsp_server()
  -- Expand Snippets Or complete by Tab ==========================================================
  local expand_or_complete = function()
    if #MiniSnippets.expand({ insert = false }) > 0 then
      vim.schedule(MiniSnippets.expand); return ''
    end
    return vim.fn.pumvisible() == 1 and
        (vim.fn.complete_info().selected == -1 and vim.keycode('<c-n><c-y>') or vim.keycode('<c-y>')) or '<Tab>'
  end
  vim.keymap.set('i', '<Tab>', expand_or_complete, { expr = true, replace_keycodes = true })
  -- exit snippet sessions on entering normal mode: ==============================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniSnippetsSessionStart',
    callback = function()
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:n',
        once = true,
        callback = function()
          while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
          end
        end
      })
    end
  })
  -- exit snippets upon reaching final tabstop: ==================================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniSnippetsSessionJump',
    callback = function(args)
      if args.data.tabstop_to == '0' then MiniSnippets.session.stop() end
    end
  })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Files                          │
--              ╰─────────────────────────────────────────────────────────╯
now_if_args(function()
  local MiniFiles = require('mini.files')
  MiniFiles.setup({
    mappings = {
      go_in_plus  = '<Tab>',
      go_out_plus = '<C-h>',
      synchronize = '<C-s>',
      close       = 'q',
      reset       = 'gh',
      mark_goto   = 'gb',
      go_in       = '',
      go_out      = '',
    },
    content = {
      filter = function(fs_entry)
        local ignore = { 'node_modules', 'build', 'depes', 'incremental' }
        local filter_hidden = not vim.tbl_contains(ignore, fs_entry.name)
        return filter_hidden and not vim.startswith(fs_entry.name, '.')
      end,
    },
    windows = {
      max_number = 1,
      width_focus = vim.o.columns,
    },
  })
  -- UI: =========================================================================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id
      -- Customize window-local settings =========================================================
      vim.wo[win_id].winblend = 15
      local config = vim.api.nvim_win_get_config(win_id)
      config.border, config.title_pos = 'single', 'left'
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
      local config = vim.api.nvim_win_get_config(args.data.win_id)
      -- Ensure fixed height =====================================================================
      config.height = vim.o.lines
      -- Ensure no title padding =================================================================
      local n = #config.title
      config.title[1][1] = config.title[1][1]:gsub('^ ', '')
      config.title[n][1] = config.title[n][1]:gsub(' $', '')
      vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
  })
  -- BookMarks: ==================================================================================
  local minifiles_augroup = vim.api.nvim_create_augroup('ec-mini-files', {})
  vim.api.nvim_create_autocmd('User', {
    group = minifiles_augroup,
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      MiniFiles.set_bookmark('c', vim.fn.stdpath('config'), { desc = 'Config' })
      MiniFiles.set_bookmark('m', vim.fn.stdpath('data') .. '/site/pack/deps/start/mini.nvim', { desc = 'mini.nvim' })
      MiniFiles.set_bookmark('p', vim.fn.stdpath('data') .. '/site/pack/deps/opt', { desc = 'Plugins' })
      MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
    end,
  })
  -- Toggle dotfiles : ===========================================================================
  local toggle = { enabled = true }
  local toggle_dotfiles = function()
    function toggle:bool()
      self.enabled = not self.enabled
      return self.enabled
    end

    local is_enabled = not toggle:bool()
    MiniFiles.refresh({
      content = {
        filter = function(fs_entry)
          local ignore = { 'node_modules', 'build', 'depes', 'incremental' }
          local filter_hidden = not vim.tbl_contains(ignore, fs_entry.name)
          return is_enabled and true or (filter_hidden and not vim.startswith(fs_entry.name, '.'))
        end,
      },
    })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args) vim.keymap.set('n', '.', toggle_dotfiles, { buffer = args.data.buf_id }) end,
  })
  -- Open In Splits : ============================================================================
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. ' split')
        return vim.api.nvim_get_current_win()
      end)
      MiniFiles.set_target_window(new_target)
    end
    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      map_split(buf_id, 'v', 'belowright horizontal')
      map_split(buf_id, 's', 'belowright vertical')
    end,
  })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Mini.Icons                          │
--              ╰─────────────────────────────────────────────────────────╯
now_if_args(function()
  local MiniIcons = require('mini.icons')
  MiniIcons.setup({
    file = {
      ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsBlue' },
      ['README.md'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['pre-commit'] = { glyph = '󰊢', hl = 'MiniIconsYellow' },
      ['Brewfile'] = { glyph = '󱄖', hl = 'MiniIconsYellow' },
      ['.ignore'] = { glyph = '󰈉', hl = 'MiniIconsGrey' },
      ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
      ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['vite.config.ts'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['pnpm-lock.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['pnpm-workspace.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['.dockerignore'] = { glyph = '󰡨', hl = 'MiniIconsBlue' },
      ['react-router.config.ts'] = { glyph = '', hl = 'MiniIconsRed' },
      ['bun.lockb'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['bun.lock'] = { glyph = '', hl = 'MiniIconsGrey' },
    },
    filetype = {
      ['css'] = { glyph = '', hl = 'MiniIconsCyan' },
      ['vim'] = { glyph = '', hl = 'MiniIconsGreen' },
    },
    extension = {
      ['d.ts'] = { glyph = '', hl = 'MiniIconsRed' },
      ['applescript'] = { glyph = '󰀵', hl = 'MiniIconsGrey' },
      ['log'] = { glyph = '󱂅', hl = 'MiniIconsGrey' },
      ['gitignore'] = { glyph = '', hl = 'MiniIconsRed' },
      ['adblock'] = { glyph = '', hl = 'MiniIconsRed' },
      ['add'] = { glyph = '', hl = 'MiniIconsGreen' },
    },
    directory = {
      ['.vscode'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['app'] = { glyph = '󰀻', hl = 'MiniIconsRed' },
      ['routes'] = { glyph = '󰑪', hl = 'MiniIconsGreen' },
      ['config'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['configs'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['server'] = { glyph = '󰒋', hl = 'MiniIconsCyan' },
      ['api'] = { glyph = '󰒋', hl = 'MiniIconsCyan' },
      ['web'] = { glyph = '󰖟', hl = 'MiniIconsBlue' },
      ['client'] = { glyph = '󰖟', hl = 'MiniIconsBlue' },
      ['database'] = { glyph = '󰆼', hl = 'MiniIconsOrange' },
      ['db'] = { glyph = '󰆼', hl = 'MiniIconsOrange' },
      ['cspell'] = { glyph = '󰓆', hl = 'MiniIconsPurple' },
    },
    lsp = {
      ['text'] = { glyph = '󰉿' },
      ['method'] = { glyph = '󰆧' },
      ['function'] = { glyph = '󰊕' },
      ['constructor'] = { glyph = '' },
      ['field'] = { glyph = '󰜢' },
      ['variable'] = { glyph = '󰀫' },
      ['class'] = { glyph = '󰠱' },
      ['interface'] = { glyph = '' },
      ['module'] = { glyph = '' },
      ['property'] = { glyph = '󰜢' },
      ['unit'] = { glyph = '󰑭' },
      ['value'] = { glyph = '󰎠' },
      ['enum'] = { glyph = '' },
      ['keyword'] = { glyph = '󰌋' },
      ['snippet'] = { glyph = '' },
      ['color'] = { glyph = '󰏘' },
      ['file'] = { glyph = '󰈙' },
      ['reference'] = { glyph = '󰈇' },
      ['folder'] = { glyph = '󰉋' },
      ['enumMember'] = { glyph = '' },
      ['constant'] = { glyph = '󰏿' },
      ['struct'] = { glyph = '󰙅' },
      ['event'] = { glyph = '' },
      ['operator'] = { glyph = '󰆕' },
      ['typeParameter'] = { glyph = '' },
    },
  })
  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind('replace'))
end)
--              ╔═════════════════════════════════════════════════════════╗
--              ║                      Treesitter                         ║
--              ╚═════════════════════════════════════════════════════════╝
now_if_args(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  local ensure_installed = {
    'bash', 'powershell', 'nu', 'c', 'cpp', 'python', 'regex',
    'html', 'css', 'scss', 'javascript', 'typescript', 'tsx', 'prisma',
    'json', 'jsonc', 'toml', 'yaml', 'lua', 'luadoc', 'vim', 'vimdoc', 'markdown', 'markdown_inline',
    'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'gitattributes', 'diff',
  }
  require('nvim-treesitter.configs').setup({
    ensure_installed = ensure_installed,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = false },
    textobjects = { enable = false },
  })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                      TS Auto Close/Rename               │
--              ╰─────────────────────────────────────────────────────────╯
now_if_args(function()
  add('windwp/nvim-ts-autotag')
  require('nvim-ts-autotag').setup()
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                    TS Rainbow delimiters                │
--              ╰─────────────────────────────────────────────────────────╯
now_if_args(function()
  add('hiphish/rainbow-delimiters.nvim')
  require('rainbow-delimiters.setup').setup()
end)
--              ╔═════════════════════════════════════════════════════════╗
--              ║                         Formatting                      ║
--              ╚═════════════════════════════════════════════════════════╝
now_if_args(function()
  add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      jsx = { 'prettier' },
      tsx = { 'prettier' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      liquid = { 'prettier' },
      c = { 'clang_format' },
      lua = { 'stylua' },
      python = { 'black' },
      tex = { 'latexindent' },
      xml = { 'xmllint' },
      svg = { 'xmllint' },
      sql = { 'sqlfluff' },
      java = { 'google-java-format' },
      groovy = { 'npm-groovy-lint' },
      ['_'] = { 'trim_whitespace' },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = 'fallback' }
    end,
  })
  vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
    require('conform').format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end)
end)
--              ╔═════════════════════════════════════════════════════════╗
--              ║                          NVIM                           ║
--              ╚═════════════════════════════════════════════════════════╝
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Neovim Colorscheme                  │
--              ╰─────────────────────────────────────────────────────────╯
now(function()
  vim.cmd.colorscheme('macro')
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Neovim Options                      │
--              ╰─────────────────────────────────────────────────────────╯
now(function()
  -- Global:  ====================================================================================
  vim.g.is_win                   = vim.uv.os_uname().sysname:find('Windows') ~= nil
  vim.g.mapleader                = vim.keycode('<space>')
  vim.g.maplocalleader           = vim.g.mapleader
  -- grep: =======================================================================================
  vim.opt.grepprg                = 'rg --vimgrep --smart-case --no-heading --color=never --glob !.git'
  vim.opt.grepformat             = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.path                   = '.,,**'
  -- Shell: =-====================================================================================
  vim.opt.sh                     = 'nu'
  vim.opt.shellcmdflag           = '--stdin --no-newline -c'
  vim.opt.shellredir             = 'out+err> %s'
  vim.opt.shellxescape           = ''
  vim.opt.shellxquote            = ''
  vim.opt.shellquote             = ''
  -- General: ====================================================================================
  vim.opt.undofile               = true
  vim.opt.wildmenu               = true
  vim.opt.wildignorecase         = true
  vim.opt.compatible             = false
  vim.opt.swapfile               = false
  vim.opt.writebackup            = false
  vim.opt.backup                 = false
  vim.opt.undolevels             = 1024
  vim.opt.fileencoding           = 'utf-8'
  vim.opt.encoding               = 'utf-8'
  vim.opt.fileformat             = 'unix'
  vim.opt.fileformats            = 'unix,dos'
  vim.opt.clipboard              = 'unnamedplus'
  vim.opt.wildmode               = 'longest:full,full'
  vim.opt.wildoptions            = 'fuzzy,pum'
  vim.opt.wildignore             = '*.zip,*.tar.gz,*.png,*.jpg,*.pdf,*.mp4,*.exe,*.pyc,*.o'
  vim.opt.omnifunc               = 'v:lua.vim.lsp.omnifunc'
  vim.opt.completeopt            = 'menuone,noselect,fuzzy,nosort'
  vim.opt.completeitemalign      = 'kind,abbr,menu'
  vim.opt.complete               = '.,w,b,kspell'
  vim.opt.switchbuf              = 'usetab'
  vim.opt.includeexpr            = "substitute(v:fname,'\\.','/','g')"
  vim.opt.shada                  = { "'10", '<0', 's10', 'h' }
  vim.opt.undodir                = vim.fn.stdpath('data') .. '/undo'
  -- Spelling ====================================================================================
  vim.opt.spell                  = false
  vim.opt.spelllang              = 'en_us'
  vim.opt.spelloptions           = 'camel'
  vim.opt.spellsuggest           = 'best,8'
  vim.opt.spellfile              = vim.fn.stdpath('config') .. '/misc/spell/en.utf-8.add'
  vim.opt.dictionary             = vim.fn.stdpath('config') .. '/misc/dict/english.txt'
  -- UI: =========================================================================================
  vim.opt.number                 = true
  vim.opt.termguicolors          = true
  vim.opt.smoothscroll           = true
  vim.opt.splitright             = true
  vim.opt.splitbelow             = true
  vim.opt.equalalways            = true
  vim.opt.tgc                    = true
  vim.opt.ttyfast                = true
  vim.opt.showcmd                = true
  vim.opt.cursorline             = true
  vim.opt.relativenumber         = false
  vim.opt.title                  = false
  vim.opt.list                   = false
  vim.opt.modeline               = false
  vim.opt.showmode               = false
  vim.opt.errorbells             = false
  vim.opt.visualbell             = false
  vim.opt.emoji                  = false
  vim.opt.ruler                  = false
  vim.opt.numberwidth            = 3
  vim.opt.linespace              = 3
  vim.opt.laststatus             = 0
  vim.opt.cmdheight              = 0
  vim.opt.helpheight             = 12
  vim.opt.previewheight          = 12
  vim.opt.winwidth               = 20
  vim.opt.winminwidth            = 10
  vim.opt.scrolloff              = 5
  vim.opt.sidescrolloff          = 5
  vim.opt.sidescroll             = 0
  vim.opt.showtabline            = 0
  vim.opt.cmdwinheight           = 30
  vim.opt.pumwidth               = 20
  vim.opt.pumheight              = 10
  vim.opt.pumblend               = 15
  vim.opt.titlelen               = 127
  vim.opt.scrollback             = 100000
  vim.opt.colorcolumn            = '+1'
  vim.opt.guicursor              = ''
  vim.opt.background             = 'dark'
  vim.opt.display                = 'lastline'
  vim.opt.showcmdloc             = 'statusline'
  vim.opt.belloff                = 'all'
  vim.opt.guifont                = 'jetBrainsMono Nerd Font:h9:b'
  vim.opt.titlestring            = '%{getcwd()} : %{expand(\"%:r\")} [%M] ― Neovim'
  vim.opt.splitkeep              = 'screen'
  vim.opt.mousemodel             = 'extend'
  vim.opt.mousescroll            = 'ver:3,hor:6'
  vim.opt.showbreak              = '󰘍'
  vim.opt.winborder              = 'single'
  vim.opt.backspace              = 'indent,eol,start'
  vim.opt.cursorlineopt          = 'screenline,number'
  vim.opt.tabclose               = 'uselast'
  vim.opt.shortmess              = 'FOSWIaco'
  vim.wo.signcolumn              = 'yes'
  vim.opt.statuscolumn           = ''
  vim.opt.fillchars              = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
  vim.opt.listchars              = { eol = '↲', tab = '→ ', trail = '+', extends = '›', precedes = '‹', space = '•', nbsp = '␣', }
  -- Editing:  ===================================================================================
  vim.opt.cindent                = true
  vim.opt.autoindent             = true
  vim.opt.expandtab              = true
  vim.opt.hlsearch               = true
  vim.opt.incsearch              = true
  vim.opt.infercase              = true
  vim.opt.smartcase              = true
  vim.opt.ignorecase             = true
  vim.opt.smartindent            = true
  vim.opt.shiftround             = true
  vim.opt.smarttab               = true
  vim.opt.gdefault               = true
  vim.opt.confirm                = true
  vim.opt.breakindent            = true
  vim.opt.linebreak              = true
  vim.opt.copyindent             = true
  vim.opt.preserveindent         = true
  vim.opt.startofline            = true
  vim.opt.wrapscan               = true
  vim.opt.tildeop                = true
  vim.opt.mousemoveevent         = true
  vim.opt.exrc                   = true
  vim.opt.secure                 = true
  vim.opt.autochdir              = true
  vim.opt.autowrite              = true
  vim.opt.autowriteall           = true
  vim.opt.showmatch              = true
  vim.opt.magic                  = false
  vim.opt.wrap                   = false
  vim.opt.joinspaces             = false
  vim.opt.textwidth              = 120
  vim.opt.matchtime              = 2
  vim.opt.wrapmargin             = 2
  vim.opt.tabstop                = 2
  vim.opt.shiftwidth             = 2
  vim.opt.softtabstop            = 2
  vim.opt.conceallevel           = 3
  vim.opt.concealcursor          = 'c'
  vim.opt.cedit                  = '^F'
  vim.opt.breakat                = [[\ \	;:,!?]]
  vim.opt.keywordprg             = ':help'
  vim.opt.breakindentopt         = 'list:-1'
  vim.opt.inccommand             = 'nosplit'
  vim.opt.jumpoptions            = 'view'
  vim.opt.selection              = 'old'
  vim.opt.nrformats              = 'bin,hex,alpha,unsigned'
  vim.opt.whichwrap              = 'b,s,<,>,[,],h,l'
  vim.opt.iskeyword              = '@,48-57,_,192-255,-'
  vim.opt.formatlistpat          = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
  vim.opt.virtualedit            = 'block'
  vim.opt.formatoptions          = 'rqnl1j'
  vim.opt.formatexpr             = "v:lua.require'conform'.formatexpr()"
  vim.opt.sessionoptions         = { 'buffers', 'curdir', 'tabpages', 'winsize', 'globals' }
  vim.opt.diffopt                = { 'algorithm:minimal', 'closeoff', 'context:8', 'filler', 'internal', 'linematch:100', 'indent-heuristic', }
  vim.opt.suffixesadd            = { '.css', '.html', '.js', '.json', '.jsx', '.lua', '.md', '.rs', '.scss', '.sh', '.ts', '.tsx', '.yaml', '.yml', }
  -- Folds:  =====================================================================================
  vim.opt.foldenable             = false
  vim.opt.foldlevelstart         = 99
  vim.opt.foldlevel              = 90
  vim.opt.foldnestmax            = 10
  vim.opt.foldminlines           = 4
  vim.opt.foldtext               = ''
  vim.opt.foldcolumn             = '0'
  vim.opt.foldmethod             = 'manual'
  vim.opt.foldopen               = 'hor,mark,tag,search,insert,quickfix,undo'
  vim.opt.foldexpr               = '0'
  -- Memory: =====================================================================================
  vim.o.timeout                  = true
  vim.opt.lazyredraw             = true
  vim.opt.hidden                 = true
  vim.opt.ttimeoutlen            = 10
  vim.opt.updatetime             = 50
  vim.opt.redrawtime             = 100
  vim.opt.history                = 100
  vim.opt.synmaxcol              = 200
  vim.opt.timeoutlen             = 300
  vim.opt.redrawtime             = 10000
  vim.opt.maxmempattern          = 10000
  -- Disable netrw: ==============================================================================
  vim.g.loaded_netrw             = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrw_gitignore   = 1
  -- Disable health checks for these providers:. =================================================
  vim.g.loaded_python_provider   = 0
  vim.g.loaded_python3_provider  = 0
  vim.g.loaded_ruby_provider     = 0
  vim.g.loaded_perl_provider     = 0
  vim.g.loaded_node_provider     = 0
  -- Disable builtin plugins: ====================================================================
  local disabled_built_ins       = {
    'osc52',
    'parser',
    'health',
    'man',
    'tohtml',
    '2html',
    'remote',
    'shadafile',
    'spellfile',
    'editorconfig',
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'matchit',
    'matchparen',
    'tar',
    'tarPlugin',
    'rrhelper',
    'spellfile_plugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
    'tutor',
    'rplugin',
    'synmenu',
    'optwin',
    'compiler',
    'bugreport',
    'ftplugin',
  }
  for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
  end
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Neovim Diagnostics                  │
--              ╰─────────────────────────────────────────────────────────╯
local diagnostic_opts = {
  severity_sort = false,
  update_in_insert = false,
  virtual_lines = false,
  virtual_text = { current_line = true, severity = { min = 'ERROR', max = 'ERROR' } },
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  signs = {
    priority = 9999,
    severity = {
      min = 'WARN',
      max = 'ERROR',
    },
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
    -- interference With Mini.Diff ===============================================================
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
  },
}
-- Use `later()` to avoid sourcing `vim.diagnostic` on startup: ==================================
later(function() vim.diagnostic.config(diagnostic_opts) end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Neovim automads                     │
--              ╰─────────────────────────────────────────────────────────╯
now_if_args(function()
  -- AutoSave: ===================================================================================
  vim.api.nvim_create_autocmd({ 'FocusLost', 'VimLeavePre' }, {
    group = vim.api.nvim_create_augroup('save_buffers', {}),
    callback = function(event)
      local buf = event.buf
      if vim.api.nvim_get_option_value('modified', { buf = buf }) then
        vim.schedule(function()
          vim.api.nvim_buf_call(buf, function()
            vim.cmd 'silent! write'
          end)
        end)
      end
    end
  })
  -- Don't Comment New Line ======================================================================
  vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
    group = vim.api.nvim_create_augroup('bg_correct', {}),
    callback = function()
      if vim.api.nvim_get_hl(0, { name = 'Normal' }).bg then
        io.write(string.format('\027]11;#%06x\027\\', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg))
      end
      vim.api.nvim_create_autocmd('UILeave', {
        callback = function()
          io.write('\027]111\027\\')
        end,
      })
    end,
  })
  -- Remove background for all WinSeparator sections =============================================
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('sp_bg_removed', { clear = true }),
    desc = 'Remove background for all WinSeparator sections',
    callback = function()
      vim.cmd('highlight WinSeparator guibg=None')
    end,
  })
  -- change tab title to directory name when loading session =====================================
  vim.api.nvim_create_autocmd('SessionLoadPost', {
    group = vim.api.nvim_create_augroup('change_title', { clear = true }),
    callback = function()
      local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      vim.uv.set_process_title(dirname .. ' - nvim')
    end,
  })
  -- Disable diagnostics in node_modules =========================================================
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('disable_diagnostics', { clear = true }),
    pattern = '*/node_modules/*',
    callback = function()
      vim.diagnostic.enable(false, { bufnr = 0 })
    end,
  })
  -- Clear the last used search pattern when opening a new buffer ================================
  vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('clear_last_search', { clear = true }),
    callback = function()
      vim.fn.setreg('/', '')
      vim.cmd 'let @/ = ""'
    end,
  })
  -- Don't Comment New Line ======================================================================
  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('diable_new_line_comments', {}),
    callback = function()
      vim.opt_local.formatoptions:remove('o')
      vim.opt_local.formatoptions:remove('r')
      vim.opt_local.formatoptions:remove('c')
    end,
  })
  -- Highlight Yank ==============================================================================
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
      callback = function()
          if vim.v.operator == 'y' then
              vim.fn.setreg("+", vim.fn.getreg("0"))
              vim.hl.on_yank({ on_macro = true, on_visual = true, higroup = 'IncSearch', timeout = 600 })
          end
      end,
  })
  -- Auto-resize splits on window resize:  =======================================================
  vim.api.nvim_create_autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd('tabdo wincmd =')
      vim.cmd('tabnext ' .. current_tab)
    end,
  })
  -- Fix broken macro recording notification for cmdheight 0 : ===================================
  local show_recordering = vim.api.nvim_create_augroup('show_recordering', { clear = true })
  vim.api.nvim_create_autocmd('RecordingEnter', {
    pattern = '*',
    group = show_recordering,
    callback = function()
      vim.opt_local.cmdheight = 1
    end,
  })
  vim.api.nvim_create_autocmd('RecordingLeave', {
    pattern = '*',
    group = show_recordering,
    desc = 'Fix broken macro recording notification for cmdheight 0, pt2',
    callback = function()
      local timer = vim.loop.new_timer()
      -- NOTE: Timer is here because we need to close cmdheight AFTER
      -- the macro is ended, not during the Leave event
      ---@diagnostic disable-next-line: need-check-nil
      timer:start(
        50,
        0,
        vim.schedule_wrap(function()
          vim.opt_local.cmdheight = 0
        end)
      )
    end,
  })
  -- Remove hl search when Move Or  enter Insert : ===============================================
  local clear_hl = vim.api.nvim_create_augroup('hl_clear', { clear = true })
  vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    group = clear_hl,
    callback = vim.schedule_wrap(function()
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end),
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = clear_hl,
    callback = function()
      if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
        vim.schedule(function()
          vim.cmd.nohlsearch()
        end)
      end
    end,
  })
  -- Trim space and lastlines if empty : =========================================================
  local trim_spaces = vim.api.nvim_create_augroup('trim_spaces', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = trim_spaces,
    callback = function()
      local curpos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, curpos)
    end,
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = trim_spaces,
    callback = function()
      local n_lines = vim.api.nvim_buf_line_count(0)
      local last_nonblank = vim.fn.prevnonblank(n_lines)
      if last_nonblank < n_lines then vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {}) end
    end,
  })
  -- Opts in command window: =====================================================================
  vim.api.nvim_create_autocmd('CmdwinEnter', {
    group = vim.api.nvim_create_augroup('cmd_open', { clear = true }),
    callback = function()
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.foldcolumn = '0'
      vim.wo.signcolumn = 'no'
      vim.wo.statuscolumn = ''
      vim.wo.colorcolumn = ''
    end,
  })
  -- Opts in terminal buffer: ====================================================================
  vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('term_open', { clear = true }),
    callback = function()
      vim.opt_local.scrolloff = 0
      vim.opt_local.spell = false
      vim.opt_local.buflisted = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.foldenable = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.foldexpr = '0'
      vim.opt_local.filetype = 'terminal'
      vim.bo.filetype = 'terminal'
    end,
  })
  -- Auto-close terminal when process exits: =====================================================
  vim.api.nvim_create_autocmd('TermClose', {
    group = vim.api.nvim_create_augroup('term_close', {}),
    callback = function()
      if vim.v.event.status == 0 then
        vim.api.nvim_buf_delete(0, {})
      end
    end,
  })
  -- Auto create directories before save: ========================================================
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
    callback = function(event)
      local file = vim.fn.fnamemodify(event.match, ':p')
      local dir = vim.fn.fnamemodify(file, ':p:h')
      local success, _ = vim.fn.isdirectory(dir)
      if not success then
        vim.fn.system({ 'mkdir', '-p', dir })
      end
    end,
  })
  -- Reload(execute) on save:=====================================================================
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('reload_on_save', { clear = true }),
    pattern = 'init.lua',
    command = 'source <afile>'
  })
  -- go to old position when opening a buffer: ===================================================
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('remember_position', { clear = true }),
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })
  -- Check if we need to reload the file when it changed: ========================================
  vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = vim.api.nvim_create_augroup('checktime', { clear = true }),
    callback = function()
      if vim.o.buftype ~= 'nofile' then
        vim.cmd('checktime')
      end
    end,
  })
  -- Close all non-existing buffers on `FocusGained`: ============================================
  vim.api.nvim_create_autocmd('FocusGained', {
    group = vim.api.nvim_create_augroup('close_non_existing_buffer', { clear = true }),
    callback = function()
      local closedBuffers = {}
      local allBufs = vim.fn.getbufinfo { buflisted = 1 }
      vim.iter(allBufs):each(function(buf)
        if not vim.api.nvim_buf_is_valid(buf.bufnr) then return end
        local stillExists = vim.uv.fs_stat(buf.name) ~= nil
        local specialBuffer = vim.bo[buf.bufnr].buftype ~= ''
        local newBuffer = buf.name == ''
        if stillExists or specialBuffer or newBuffer then return end
        table.insert(closedBuffers, vim.fs.basename(buf.name))
        vim.api.nvim_buf_delete(buf.bufnr, { force = false })
      end)
      if #closedBuffers == 0 then return end
      if #closedBuffers == 1 then
        vim.notify(closedBuffers[1], nil, { title = 'Buffer closed', icon = '󰅗' })
      else
        local text = '- ' .. table.concat(closedBuffers, '\n- ')
        vim.notify(text, nil, { title = 'Buffers closed', icon = '󰅗' })
      end
      vim.schedule(function()
        if vim.api.nvim_buf_get_name(0) ~= '' then return end
        for _, file in ipairs(vim.v.oldfiles) do
          if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= 'COMMIT_EDITMSG' then
            vim.cmd.edit(file)
            return
          end
        end
      end)
    end,
  })
  -- Auto-cleanup. delete older files: ===========================================================
  vim.api.nvim_create_autocmd('FocusLost', {
    group = vim.api.nvim_create_augroup('auto-cleanup', { clear = true }),
    once = true,
    callback = function()
      if os.date('%a') == 'Mon' or jit.os == 'OSX' then
        vim.system { 'find', vim.o.undodir, '-mtime', '+15d', '-delete' }
        vim.system { 'find', vim.lsp.log.get_filename(), '-size', '+20M', '-delete' }
      end
    end,
  })
  -- Reload buffer on enter or focus: ============================================================
  vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    group = vim.api.nvim_create_augroup('reload_buffer_on_enteror_focus', { clear = true }),
    command = 'silent! !',
  })
  -- Always open quickfix window automatically: ==================================================
  vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    group = vim.api.nvim_create_augroup('auto_open_quickfix', { clear = true }),
    pattern = { '[^l]*' },
    command = 'cwindow'
  })
  -- Always show quotes: =========================================================================
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'json', 'jsonc', 'markdown' },
    callback = function()
      vim.wo.conceallevel = 0
    end,
  })
  -- Disallow change buf for quickfix: ===========================================================
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('noedit_quickfix', { clear = true }),
    pattern = 'qf',
    desc = 'Disallow change buf for quickfix',
    callback = function()
      vim.wo.winfixbuf = true
    end,
  })
  -- delete entries from a quickfix list with `dd` ===============================================
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('quickfix', { clear = true }),
    pattern = { 'qf' },
    callback = function()
      vim.keymap.set('n', 'dd', function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local quickfix_list = vim.fn.getqflist()
        table.remove(quickfix_list, cursor[1])
        vim.fn.setqflist(quickfix_list, 'r')
        vim.api.nvim_win_set_cursor(0, cursor)
        if #quickfix_list == 0 then
          vim.cmd.cclose()
        end
      end, { buffer = true })
      vim.keymap.set('n', '<cr>', '<cr>:cclose<cr>', { buffer = 0, silent = true })
    end,
  })
  -- Start insert mode in git commit messages: ===================================================
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('git_insert', { clear = true }),
    pattern = { 'gitcommit', 'gitrebase' },
    command = 'startinsert | 1',
  })
  -- clear jump list at start:====================================================================
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('clear_jumps', { clear = true }),
    callback = function()
      vim.cmd('clearjumps')
    end,
  })
  -- When at eob, bring the current line towards center screen:===================================
  vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorMoved', 'CursorHoldI' }, {
    group = vim.api.nvim_create_augroup('at_eob', { clear = true }),
    callback = function(event)
      local bo = vim.bo[event.buf]
      if bo.filetype ~= 'minifiles' then
        local win_h = vim.api.nvim_win_get_height(0)
        local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
        local dist = vim.fn.line('$') - vim.fn.line('.')
        local rem = vim.fn.line('w$') - vim.fn.line('w0') + 1

        if dist < off and win_h - rem + dist < off then
          local view = vim.fn.winsaveview()
          view.topline = view.topline + off - (win_h - rem + dist)
          vim.fn.winrestview(view)
        end
      end
    end,
  })
  -- close some filetypes with <q>: ==============================================================
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('q_close', { clear = true }),
    pattern = { 'qf', 'man', 'help', 'query', 'notify', 'lspinfo', 'startuptime', 'checkhealth' },
    callback = function(event)
      local bo = vim.bo[event.buf]
      if bo.filetype ~= 'markdown' or bo.buftype == 'help' then
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
      end
    end,
  })
  -- Large file handling: ========================================================================
  vim.api.nvim_create_autocmd('BufReadPre', {
    group = vim.api.nvim_create_augroup('handle_bigfile', { clear = true }),
    callback = function(ev)
      local max_size = 10 * 1024 * 1024 -- 10MB
      local file_size = vim.fn.getfsize(ev.match)
      if file_size > max_size or file_size == -2 then
        vim.bo.indentexpr = ''
        vim.bo.autoindent = false
        vim.bo.smartindent = false
        vim.opt_local.spell = false
        vim.opt_local.undofile = false
        vim.opt_local.swapfile = false
        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
        vim.opt_local.foldenable = false
        vim.opt_local.foldmethod = 'manual'
        vim.opt_local.foldexpr = '0'
        vim.opt_local.statuscolumn = ''
        vim.cmd('filetype off')
        vim.cmd('syntax clear')
        vim.cmd('syntax off')
        vim.defer_fn(function()
          vim.cmd('TSBufDisable highlight')
          vim.cmd('TSBufDisable indent')
          vim.cmd('TSBufDisable autotag')
          require('rainbow-delimiters').disable(0)
        end, 100)
        vim.b.minicompletion_disable = true
        vim.b.minisnippets_disable = true
        vim.b.minihipatterns_disable = true
        vim.notify('Large file detected. Some features disabled.', vim.log.levels.WARN)
      end
    end,
  })
  -- Create an autocmd group for executing files: ================================================
  local exec_by_ft = vim.api.nvim_create_augroup('exec_by_ft', { clear = true })
  local function RunKeymap(filetype, command)
    vim.api.nvim_create_autocmd('FileType', {
      group = exec_by_ft,
      pattern = filetype,
      callback = function()
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>a',
          ':w<cr>:split term://' .. command .. ' %<cr>:resize 10<cr>',
          { noremap = true, silent = true }
        )
      end,
    })
  end
  -- Define the commands for each filetype
  RunKeymap('lua', 'lua')
  RunKeymap('python', 'python3')
  RunKeymap('javascript', 'node')
  RunKeymap('rust', 'cargo run')
  RunKeymap('go', 'go run')
  RunKeymap('cpp', 'g++ % -o %:r && ./%:r')
  RunKeymap('c', 'gcc % -o %:r && ./%:r')
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                 Neovim user_commands                    │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  -- Source and edit vimrc file =================================================================
  vim.api.nvim_create_user_command('SourceVimrc', 'silent source $MYVIMRC', { bang = true })
  vim.api.nvim_create_user_command('VimrcSource', 'silent source $MYVIMRC', { bang = true })
  vim.api.nvim_create_user_command('EditVimrc', 'edit $MYVIMRC', { bang = true })
  vim.api.nvim_create_user_command('VimrcEdit', 'edit $MYVIMRC', { bang = true })
  -- Change working directory to current file's: =================================================
  vim.api.nvim_create_user_command('CdHere', 'cd %:p:h', {})
  -- Change tab page's working directory to current file's: ======================================
  vim.api.nvim_create_user_command('TcdHere', 'tcd %:p:h', {})
  -- Run ctags: ==================================================================================
  vim.api.nvim_create_user_command('Ctags', '!ctags -R .', {})
  -- LSP code action:=============================================================================
  vim.api.nvim_create_user_command('CodeAction', function() vim.lsp.buf.code_action() end, {})
  -- Search literally, with no regex: ============================================================
  vim.api.nvim_create_user_command('Search', ':let @/="\\\\V" . escape(<q-args>, "\\\\\") | normal! n', { nargs = 1 })
  -- Grep keyword within the folder containing the current file: =================================
  vim.api.nvim_create_user_command('Grep', function(opts)
    local keyword = opts.args
    vim.cmd('vimgrep ' .. keyword .. ' %:p:.:h/**/*')
  end, { nargs = 1, })
  -- Tmp is a command to create a temporary file: ================================================
  vim.api.nvim_create_user_command('Tmp', function()
    local path = vim.fn.tempname()
    vim.cmd('e ' .. path)
    vim.notify(path)
    -- delete the file when the buffer is closed
    vim.cmd('au BufDelete <buffer> !rm -f ' .. path)
  end, { nargs = '*' })
  -- Toggle inlay hints: =========================================================================
  vim.api.nvim_create_user_command('ToggleInlayHints', function()
    vim.g.inlay_hints = not vim.g.inlay_hints
    vim.notify(string.format('%s inlay hints...', vim.g.inlay_hints and 'Enabling' or 'Disabling'), vim.log.levels.INFO)
    local mode = vim.api.nvim_get_mode().mode
    vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == 'n' or mode == 'v'))
  end, { nargs = 0 })
  -- Print and copy file full path: ==============================================================
  vim.api.nvim_create_user_command('Path', function()
    local path = vim.fn.expand('%:p')
    if path == '' then return end
    vim.notify(path)
    vim.fn.setreg('+', path)
  end, {})
  -- Toggle conform.nvim auto-formatting: ========================================================
  vim.api.nvim_create_user_command('ToggleFormat', function()
    vim.g.autoformat = not vim.g.autoformat
    vim.notify(string.format('%s formatting...', vim.g.autoformat and 'Enabling' or 'Disabling'), vim.log.levels.INFO)
  end, { nargs = 0 })
  -- Enable Format: ===============================================================================
  vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end
    require('conform').format({ async = true, lsp_format = 'fallback', range = range })
  end, { range = true })
  -- Enable FormatOnSave ==========================================================================
  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.notify('Format On Save Enable')
  end, {})
  -- Disable FormatOnSave ========================================================================
  vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
    vim.notify('Format On Save Disable')
  end, { bang = true, })
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                Neovim misspelled_commands               │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  local misspelled_commands = { 'W', 'Wq', 'WQ', 'Q', 'Qa', 'QA', 'Wqa', 'WQa', 'WQA' }
  for _, command in pairs(misspelled_commands) do
    vim.api.nvim_create_user_command(command, function()
      vim.cmd(string.lower(command))
    end, { bang = true })
  end
end)
--              ╭─────────────────────────────────────────────────────────╮
--              │                     Neovim keymaps                      │
--              ╰─────────────────────────────────────────────────────────╯
later(function()
  -- General: ====================================================================================
  vim.keymap.set('n', '<leader>q', '<cmd>close<cr>')
  vim.keymap.set('n', '<leader>wq', '<cmd>close<cr>')
  vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>')
  vim.keymap.set('n', '<C-s>', '<cmd>silent up<cr>')
  vim.keymap.set('i', '<C-s>', '<ESC> <cmd>up<cr>')
  vim.keymap.set('i', '<c-y>', '<Esc>viwUea')
  vim.keymap.set('i', '<c-t>', '<Esc>b~lea')
  vim.keymap.set('i', '<C-A>', '<HOME>')
  vim.keymap.set('i', '<C-E>', '<END>')
  vim.keymap.set('c', '<C-A>', '<HOME>')
  vim.keymap.set('i', '<C-l>', '<space>=><space>')
  vim.keymap.set('i', '<C-h>', '<space><=<space>')
  vim.keymap.set('n', '<C-c>', 'cit')
  vim.keymap.set('n', 'gk', 'gg')
  vim.keymap.set('n', 'gj', 'G')
  vim.keymap.set('n', 'gh', '^')
  vim.keymap.set('n', 'gl', 'g_')
  vim.keymap.set('v', 'gk', 'gg')
  vim.keymap.set('v', 'gj', 'G')
  vim.keymap.set('v', 'gh', '^')
  vim.keymap.set('v', 'gl', '$')
  vim.keymap.set('n', ';', ':')
  vim.keymap.set('x', ';', ':')
  vim.keymap.set('n', 'U', '<C-r>')
  vim.keymap.set('n', 'Q', '<nop>')
  vim.keymap.set('n', '<Space>', '<Nop>')
  vim.keymap.set('n', '<ESC>', ':nohl<cr>')
  vim.keymap.set('n', 'yco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>')
  vim.keymap.set('n', 'ycO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>')
  vim.keymap.set('n', 'J', 'mzJ`z:delmarks z<cr>')
  vim.keymap.set('x', '/', '<Esc>/\\%V')
  vim.keymap.set('x', 'R', ':s###g<left><left><left>')
  vim.keymap.set('n', '<leader>y', '<cmd>%yank<cr>')
  vim.keymap.set('v', 'y', 'y`]')
  vim.keymap.set('v', 'p', 'p`]')
  vim.keymap.set('n', 'p', 'p`]')
  vim.keymap.set('x', 'gr', '"_dP')
  vim.keymap.set('n', 'x', '"_x')
  vim.keymap.set('n', 'c', '"_c')
  vim.keymap.set('n', 'cc', '"_cc')
  vim.keymap.set('n', 'C', '"_C')
  vim.keymap.set('x', 'c', '"_c')
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')
  vim.keymap.set('v', '<TAB>', '>gv')
  vim.keymap.set('v', '<S-TAB>', '<gv')
  vim.keymap.set('x', '<TAB>', '>gv')
  vim.keymap.set('x', '<S-TAB>', '<gv')
  vim.keymap.set('x', '$', 'g_')
  vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv")
  vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv")
  vim.keymap.set('c', '%%', "<C-R>=expand('%:h').'/'<cr>")
  vim.keymap.set('n', '<leader>nc', ':e ~/.config/nvim/init.lua<cr>')
  vim.keymap.set('n', '<leader>p', 'm`o<ESC>p``')
  vim.keymap.set('n', '<leader>P', 'm`O<ESC>p``')
  vim.keymap.set('n', '<leader>uu', ':earlier ')
  vim.keymap.set('n', '<leader><leader>', 'zz')
  vim.keymap.set('n', '~', 'v~')
  vim.keymap.set('x', '/', '<esc>/\\%V')
  vim.keymap.set('n', 'g/', '*')
  vim.keymap.set('n', 'gy', '`[v`]')
  vim.keymap.set('n', '<C-m>', '%')
  vim.keymap.set('n', '<C-n>', '*N', { remap = true })
  vim.keymap.set('n', 'ycc', 'yygccp', { remap = true })
  vim.keymap.set('n', '<space>o', "printf('m`%so<ESC>``', v:count1)", { expr = true })
  vim.keymap.set('n', '<space>O', "printf('m`%sO<ESC>``', v:count1)", { expr = true })
  vim.keymap.set('n', '<leader>v', "printf('`[%s`]', getregtype()[0])", { expr = true, })
  vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false })
  -- Completion: ======================================================================================
  vim.keymap.set('i', '<C-j>', [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
  vim.keymap.set('i', '<C-k>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })
  -- window: =====================================================================================
  vim.keymap.set('n', '<leader>wc', '<cmd>close<cr>')
  vim.keymap.set('n', '<leader>wo', '<cmd>only<cr>')
  vim.keymap.set('n', '<leader>wv', '<cmd>split<cr>')
  vim.keymap.set('n', '<leader>ws', '<cmd>vsplit<cr>')
  vim.keymap.set('n', '<leader>|', '<cmd>wincmd v<cr>')
  vim.keymap.set('n', '<leader>-', '<cmd>wincmd s<cr>')
  vim.keymap.set('n', '<leader>wT', '<cmd>wincmd T<cr>')
  vim.keymap.set('n', '<leader>wr', '<cmd>wincmd r<cr>')
  vim.keymap.set('n', '<leader>wR', '<cmd>wincmd R<cr>')
  vim.keymap.set('n', '<leader>wH', '<cmd>wincmd H<cr>')
  vim.keymap.set('n', '<leader>wJ', '<cmd>wincmd J<cr>')
  vim.keymap.set('n', '<leader>wK', '<cmd>wincmd K<cr>')
  vim.keymap.set('n', '<leader>wL', '<cmd>wincmd L<cr>')
  vim.keymap.set('n', '<leader>w=', '<cmd>wincmd =<cr>')
  vim.keymap.set('n', '<leader>wk', '<cmd>resize +5<cr>')
  vim.keymap.set('n', '<leader>wj', '<cmd>resize -5<cr>')
  vim.keymap.set('n', '<leader>wh', '<cmd>vertical resize +3<cr>')
  vim.keymap.set('n', '<leader>wl', '<cmd>vertical resize -3<cr>')
  -- Focus : =====================================================================================
  vim.keymap.set('n', '<C-H>', '<C-w>h')
  vim.keymap.set('n', '<C-J>', '<C-w>j')
  vim.keymap.set('n', '<C-K>', '<C-w>k')
  vim.keymap.set('n', '<C-L>', '<C-w>l')
  -- Move: =======================================================================================
  vim.keymap.set('n', '<leader>L', '<C-w>L')
  vim.keymap.set('n', '<leader>H', '<C-w>H')
  vim.keymap.set('n', '<leader>K', '<C-w>K')
  vim.keymap.set('n', '<leader>J', '<C-w>J')
  -- Resize:  ====================================================================================
  vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>')
  vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>')
  vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>')
  vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>')
  -- Buffers: ====================================================================================
  vim.keymap.set('n', '<Tab>', '<cmd>bnext<cr>')
  vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<cr>')
  vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>')
  vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>')
  -- Center:  ====================================================================================
  vim.keymap.set('n', 'n', 'nzzzv')
  vim.keymap.set('n', 'N', 'Nzzzv')
  vim.keymap.set('n', '<C-d>', '<C-d>zz')
  vim.keymap.set('n', '<C-u>', '<C-u>zz')
  -- Theme: ======================================================================================
  vim.keymap.set('n', '<leader>td', '<cmd>set background=dark<cr>')
  vim.keymap.set('n', '<leader>tl', '<cmd>set background=light<cr>')
  vim.keymap.set('n', '<leader>tr', '<cmd>colorscheme randomhue<cr>')
  -- Marks: ======================================================================================
  vim.keymap.set('n', '<leader>mm', '<cmd>CycleMarks<cr>')
  vim.keymap.set('n', '<leader>mr', '<cmd>DeleteAllMarks<cr>')
  vim.keymap.set('n', '<leader>ms', '<cmd>SetCycleMarksDynamic<cr>')
  vim.keymap.set('n', '<leader>fm', '<cmd>PickMark<cr>')
  -- Subtitle Keys: ==============================================================================
  vim.keymap.set('n', '<Leader>rs', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
  vim.keymap.set('n', '<leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
  -- Jumps: ======================================================================================
  vim.keymap.set('n', '<C-o>', '<C-o>')
  vim.keymap.set('n', '<C-p>', '<C-i>')
  -- Misc: =======================================================================================
  vim.keymap.set('n', 'gx', '<cmd>OpenUrlInBuffer<cr>')
  vim.keymap.set('n', '<leader>j', '<cmd>SmartDuplicate<cr>')
  vim.keymap.set('n', '<leader>s', '<cmd>ToggleWorld<cr>')
  vim.keymap.set('n', '<leader>lc', '<cmd>LspCapabilities<cr>')
  vim.keymap.set('n', '<leader>`', '<cmd>ToggleTitleCase<cr>')
  vim.keymap.set('n', '<leader>bm', '<cmd>ZoomToggle<cr>')
  vim.keymap.set('n', '<leader>bd', '<cmd>DeleteBuffer<cr>')
  vim.keymap.set('n', '<leader>bb', '<cmd>DeleteOtherBuffers<cr>')
  -- Terminal: ===================================================================================
  vim.keymap.set('n', '<C-t>', '<cmd>FloatTermToggle<cr>')
  vim.keymap.set('t', '<C-t>', '<cmd>FloatTermToggle<cr>')
  vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>')
  -- Git: ========================================================================================
  vim.keymap.set('n', '<leader>ga', '<cmd>Git add .<cr>')
  vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>')
  vim.keymap.set('n', '<leader>gC', '<Cmd>Git commit --amend<cr>')
  vim.keymap.set('n', '<leader>gp', '<cmd>Git push -u origin main<cr>')
  vim.keymap.set('n', '<leader>gP', '<cmd>Git pull<cr>')
  vim.keymap.set('n', '<leader>gd', '<Cmd>Git diff<cr>')
  vim.keymap.set('n', '<leader>gD', '<Cmd>Git diff -- %<cr>')
  vim.keymap.set('n', '<leader>gs', '<Cmd>lua MiniGit.show_at_cursor()<cr>')
  vim.keymap.set('n', '<leader>gl', [[<Cmd>Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order<cr>]])
  vim.keymap.set('n', '<leader>gh', [[<Cmd>lua MiniDiff.toggle_overlay()<cr>]])
  vim.keymap.set('n', '<leader>gx', [[<Cmd>lua MiniGit.show_at_cursor()<cr>]])
  -- Picker ======================================================================================
  vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers include_current=false<cr>')
  vim.keymap.set('n', '<leader>fl', '<cmd>Pick buf_lines scope="current"<cr>')
  vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>')
  vim.keymap.set('n', '<leader>fr', '<cmd>Pick oldfiles<cr>')
  vim.keymap.set('n', '<leader>ft', '<cmd>Pick grep_live<cr>')
  vim.keymap.set('n', '<leader>fe', '<cmd>Pick explorer<cr>')
  vim.keymap.set('n', '<leader>fn', '<cmd>Pick hipatterns<cr>')
  vim.keymap.set('n', '<leader>fo', '<cmd>Pick options<cr>')
  vim.keymap.set('n', '<leader>fp', '<cmd>Pick registers<cr>')
  vim.keymap.set('n', '<leader>fk', '<cmd>Pick keymaps<cr>')
  vim.keymap.set('n', '<leader>fc', '<cmd>Pick commands<cr>')
  vim.keymap.set('n', '<leader>fh', '<cmd>Pick history<cr>')
  vim.keymap.set('n', '<leader>tp', '<cmd>Pick colorschemes<cr>')
  vim.keymap.set('n', '<leader>fgf', '<cmd>Pick git_files<cr>')
  vim.keymap.set('n', '<leader>fgd', '<cmd>Pick git_hunks<cr>')
  vim.keymap.set('n', '<leader>fgc', '<cmd>Pick git_commits<cr>')
  vim.keymap.set('n', '<leader>fgb', '<cmd>Pick git_branches<cr>')
  vim.keymap.set('n', 'gR', "<Cmd>Pick lsp scope='references'<cr>")
  vim.keymap.set('n', 'gD', "<Cmd>Pick lsp scope='definition'<cr>")
  vim.keymap.set('n', 'gI', "<Cmd>Pick lsp scope='declaration'<cr>")
  vim.keymap.set('n', 'gS', "<Cmd>Pick lsp scope='document_symbol'<cr>")
  -- Brackted: ===================================================================================
  vim.keymap.set('n', '[a', '<cmd>previous<cr>')
  vim.keymap.set('n', ']a', '<cmd>next<cr>')
  vim.keymap.set('n', '[b', '<cmd>bprevious<cr>')
  vim.keymap.set('n', ']b', '<cmd>bnext<cr>')
  vim.keymap.set('n', '[q', '<cmd>cprevious<cr>')
  vim.keymap.set('n', ']q', '<cmd>cnext<cr>')
  vim.keymap.set('n', '[Q', '<cmd>cfirst<cr>')
  vim.keymap.set('n', ']Q', '<cmd>clast<cr>')
  vim.keymap.set('n', '[l', '<cmd>lprevious<cr>')
  vim.keymap.set('n', ']l', '<cmd>lnext<cr>')
  vim.keymap.set('n', '[<space>', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
  vim.keymap.set('n', ']<space>', ":<c-u>put =repeat(nr2char(10), v:count1)<cr>']")
  vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
  vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
  vim.keymap.set('n', '[c', function() require('mini.diff').goto_hunk('prev') end)
  vim.keymap.set('n', ']c', function() require('mini.diff').goto_hunk('next') end)
  -- Explorer: ====================================================================================
  vim.keymap.set('n', '<leader>e', function() require('mini.files').open(vim.bo.buftype ~= 'nofile' and vim.api.nvim_buf_get_name(0) or nil, true) end)
  vim.keymap.set('n', '<leader>E', function() require('mini.files').open(vim.uv.cwd(), true) end)
end)
--              ╔═════════════════════════════════════════════════════════╗
--              ║                          Neovide                        ║
--              ╚═════════════════════════════════════════════════════════╝
later(function()
  if vim.g.neovide then
    -- General: ==================================================================================
    vim.g.neovide_scale_factor = 1
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_left = 0
    -- Appearance: ===============================================================================
    vim.g.neovide_opacity = 1
    vim.g.neovide_underline_stroke_scale = 2.5
    vim.g.neovide_show_border = true
    -- floating: =================================================================================
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    -- behavior: =================================================================================
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    -- cursor: ===================================================================================
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.00
    -- Keymap: ===================================================================================
    vim.keymap.set({ 'n', 'v' }, '<C-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<cr>')
    vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<cr>')
    vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<cr>')
  end
end)
--              ╔═════════════════════════════════════════════════════════╗
--              ║                          FileType                       ║
--              ╚═════════════════════════════════════════════════════════╝
later(function()
  vim.filetype.add({
    extension = {
      ['http'] = 'http',
      ['json'] = 'jsonc',
      ['map'] = 'json',
      ['mdx'] = 'markdown',
      ['ipynb'] = 'ipynb',
      ['pcss'] = 'css',
      ['ejs'] = 'ejs',
      ['conf'] = 'conf',
      ['ahk2'] = 'autohotkey',
      ['xaml'] = 'xml',
      ['h'] = 'c',
    },
    filename = {
      ['TODO'] = 'markdown',
      ['README'] = 'markdown',
      ['readme'] = 'markdown',
      ['xhtml'] = 'html',
      ['tsconfig.json'] = 'jsonc',
      ['.eslintrc.json'] = 'jsonc',
      ['.prettierrc'] = 'jsonc',
      ['.babelrc'] = 'jsonc',
      ['.stylelintrc'] = 'jsonc',
      ['.yamlfmt'] = 'yaml',
    },
    pattern = {
      ['requirements.*.txt'] = 'requirements',
      ['.*config/git/config'] = 'gitconfig',
      ['.*/git/config.*'] = 'git_config',
      ['.gitconfig.*'] = 'gitconfig',
      ['%.env%.[%w_.-]+'] = 'sh',
      ['.*/*.conf*'] = 'conf',
      ['*.MD'] = 'markdown',
      ['Dockerfile*'] = 'dockerfile',
      ['*.dockerfile'] = 'dockerfile',
      ['*.user.css'] = 'ess',
    },
  })
end)
