vim.cmd('setlocal nonumber norelativenumber')
vim.cmd('setlocal spell wrap')
vim.cmd('setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr() foldlevel=1')
