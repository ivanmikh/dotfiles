local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_create_user_command

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Move between splits (and tmux panes). tmux forwards M-<hjkl> verbatim, so the
-- terminal-mode variant escapes to normal mode first instead of hijacking C-h.
for key, dir in pairs({ h = 'Left', j = 'Down', k = 'Up', l = 'Right' }) do
  keymap('n', '<M-' .. key .. '>', '<cmd>TmuxNavigate' .. dir .. '<CR>', opts)
  keymap('t', '<M-' .. key .. '>', '<C-\\><C-N><cmd>TmuxNavigate' .. dir .. '<CR>', opts)
end

-- In terminal
keymap('t', '<M-\\>', '<C-\\><C-N>', opts)

-- Move vertically by visual line
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('v', 'j', 'gj', opts)
keymap('v', 'k', 'gk', opts)

-- Paste/delete without yanking selected
--keymap('v', 'p', '"_dp', opts)
--keymap('v', 'P', '"_dP', opts)
keymap('v', 'x', '"_x', opts)
keymap('n', 'x', '"_x', opts)

-- Resize with Alt+Shift+<key>
keymap("n", "<M-K>", ":resize -2<CR>", opts)
keymap("n", "<M-J>", ":resize +2<CR>", opts)
keymap("n", "<M-H>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-L>", ":vertical resize +2<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Tabs
keymap('n', '[t', ':tabprevious<CR>', opts)
keymap('n', ']t', ':tabnext<CR>', opts)
keymap('n', '[T', ':tabfirst<CR>', opts)
keymap('n', ']T', ':tablast<CR>', opts)

-- List buffers
keymap('n', 'gb', ':ls<CR>:b<space>', { noremap = true } )

-- Commands
cmd('CopyAbsPath', ':let @+ = expand("%:p")', {})
cmd('CopyRelPath', ':let @+ = expand("%:f")', {})
cmd('CopyFilename', ':let @+ = expand("%:t")', {})
cmd('CopyForClaude', function(o)
  local ref = '@' .. vim.fn.expand('%:.') .. '#L' .. o.line1
  if o.line2 ~= o.line1 then ref = ref .. '-' .. o.line2 end
  vim.fn.setreg('+', ref)
  vim.notify('Copied ' .. ref)
end, { range = true })

-- Copy keymaps
keymap('v', '<leader>yc', ':CopyForClaude<CR>', opts)
keymap('n', '<leader>yr', ':CopyRelPath<CR>', opts)
keymap('n', '<leader>ya', ':CopyAbsPath<CR>', opts)
