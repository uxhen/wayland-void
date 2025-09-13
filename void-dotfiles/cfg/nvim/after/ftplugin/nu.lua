vim.opt_local.commentstring = '# %s'

if vim.g.is_win then
  -- from: https://discord.com/channels/601130461678272522/1235711557778804746/1235711946934845571
  -- line 1: Interpret the whole message as an error message
  --    %E        start of a multi-line error message
  --    'Error:'  is the pattern indicating the start of the error message
  --    %.%#      is like .* with regex (capture all or nothing)
  -- line 2: Capture the error message
  --     %C       continuation of a multi-line message
  --     %s       search for a text
  --     ' × '    the text before the error message
  --     %m       error message
  -- line 3: Capture the file path, line & column number
  --     %C       continuation of a multi-line message
  --     %s       search for a text
  --     '╭─['    the text before the the file path
  --     %f       the file path
  --     ':'        ...followed by a colon
  --     %l         ...followed by the line number
  --     ':'        ...followed by a colon
  --     %c         ...followed by the column number
  --     ']'        ...ending with a ]
  -- line4: Skip everything that don't match the previous patterns
  --   %C       continuation of a multi-line message
  --   %.%#     is like .* with regex (capture all or nothing)
  local err_fmt = {
    '%EError:%.%#',
    '%C%s × %m',
    '%C%s╭─[%f:%l:%c]',
    '%C%.%#',
  }
  vim.opt_local.errorformat = table.concat(err_fmt, ',')
  vim.opt_local.makeprg = 'nu %'
end
