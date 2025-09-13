--          ╔═════════════════════════════════════════════════════════╗
--          ║                       Box Comments                      ║
--          ╚═════════════════════════════════════════════════════════╝
vim.keymap.set('n', 'gcb', function(symbol, total_width)
  local count = vim.v.count1

  symbol = symbol or '─'
  total_width = total_width or 79

  local tl, tr, bl, br = '╭', '╮', '╰', '╯'
  local horizontal, vertical = '─', '│'
  local comment_string = vim.bo.commentstring:gsub('%%s', ' ')
  local line_num = vim.fn.line('.')

  local border_top = comment_string .. tl .. string.rep(horizontal, total_width - #comment_string - 2) .. tr
  local border_bottom = comment_string .. bl .. string.rep(horizontal, total_width - #comment_string - 2) .. br
  local text_lines = {}
  for _ = 1, count do
    local text = ' '
    local padding = math.floor((total_width - #comment_string - 2 - #text) / 2)
    local text_line = comment_string
        .. vertical
        .. string.rep(' ', padding)
        .. text
        .. string.rep(' ', total_width - #comment_string - 2 - #text - padding)
        .. vertical
    table.insert(text_lines, text_line)
  end

  local content = { border_top }
  for _, line in ipairs(text_lines) do
    table.insert(content, line)
  end
  table.insert(content, border_bottom)

  vim.fn.append(line_num, content)

  local inner_start = #comment_string + 5
  vim.fn.cursor(line_num + 2, inner_start)
  vim.cmd([[startreplace]])
end)
