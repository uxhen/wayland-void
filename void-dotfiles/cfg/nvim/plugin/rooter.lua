--          ╔═════════════════════════════════════════════════════════╗
--          ║                        Rooter                           ║
--          ╚═════════════════════════════════════════════════════════╝
local M = {
  config = {
    dirs = {
      -- version control markers: ================================================================
      '.git/',
      '_darcs/',
      '.hg/',
      '.bzr/',
      '.svn/',
      -- exrc markers: ===========================================================================
      '.nvim.lua',
      '.nvimrc',
      '.exrc',
      -- generic root markers: ===================================================================
      '.editorconfig',
      'Makefile',
      -- javascript: =============================================================================
      'node_modules/',
      'package.json',
      -- python: =================================================================================
      '.venv/',
      'pyproject.toml',
      '.pylintrc',
      'requirements.txt',
      'setup.py',
      -- c: ======================================================================================
      'CMakeLists.txt',
      'Makefile',
      -- rust: ===================================================================================
      'Cargo.toml',
      -- go: =====================================================================================
      'go.mod',
      -- java: ===================================================================================
      'mvnw',
      'gradlew',
    },
  },
}

local root_cache = {}
local function find_root(markers)
  local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local bufdirname = vim.fn.fnamemodify(bufname, ':p:h'):gsub('oil://', '')
  if root_cache[bufdirname] then
    return root_cache[bufdirname]
  end

  local root_dir = vim.fs.root(bufdirname, markers)
  if root_dir then
    root_cache[bufdirname] = root_dir
    return root_dir
  end
  return nil
end

function M.setup(config)
  M.config = vim.tbl_deep_extend('force', M.config, config or {})
  local group = vim.api.nvim_create_augroup('myplugins-rooter', { clear = true })
  -- Disable conflicting option: =================================================================
  vim.o.autochdir = false
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter' }, {
    group = group,
    desc = 'myplugins: Set current directory to project root',
    pattern = '*',
    nested = true,
    callback = function(args)
      local root_dir = find_root(M.config.dirs)
      if root_dir then
        vim.api.nvim_set_current_dir(root_dir)
        if args.buf then
          vim.b.workspace_folder = root_dir
        end
      end
    end,
  })
end

M.setup()
