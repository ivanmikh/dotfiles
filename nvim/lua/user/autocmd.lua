-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Restore cursor position
-- Small re-implementation of the suggested autocmd in :h restore-cursor
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Justfile = makefile
vim.cmd [[
  autocmd BufNewFile,BufRead justfile set filetype=make
]]

