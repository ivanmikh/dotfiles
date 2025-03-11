local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local function location()
    local line = vim.fn.line('.')
    local total = vim.fn.line('$')
    local col = vim.fn.charcol('.')
    return string.format('%3d:%-2d/ %d', line, col, total)
  end

  require('lualine').setup {
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = { "neo-tree" },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          icon = ""
        },
        'diff'
      },
      lualine_c = {
        {
          'filename',
          file_status = true,
          newfile_status = true,
          path = 1,  -- 0: Just the filename
                     -- 1: Relative path
                     -- 2: Absolute path
                     -- 3: Absolute path, with tilde as the home directory
                     -- 4: Filename and parent dir, with tilde as the home directory
          shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[RO]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
        }
      },
      lualine_x = {
        'encoding',
        {
          'fileformat',
          symbols = {
            unix = 'UNIX',
            dos = 'DOS',
            mac = 'MAC',
          }
        },
        {
          'filetype',
          colored = false,
          icon = ''
        }
      },
      lualine_y = { 'progress' },
      lualine_z = { location }
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
