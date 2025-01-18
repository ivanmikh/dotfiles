local opts = { noremap = true, silent = true }
local cmd_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_create_user_command

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Move between splits
keymap('n', '<M-h>', '<C-w><C-h>', opts)
keymap('n', '<M-l>', '<C-w><C-l>', opts)
keymap('n', '<M-j>', '<C-w><C-j>', opts)
keymap('n', '<M-k>', '<C-w><C-k>', opts)

-- Move vertically by visual line
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('v', 'j', 'gj', opts)
keymap('v', 'k', 'gk', opts)

-- Paste/delete without yanking selected
keymap('v', 'p', '"_dp', opts)
keymap('v', 'P', '"_dP', opts)
keymap('v', 'x', '"_x', opts)
keymap('n', 'x', '"_x', opts)

-- Resize with Alt+Shift+<key>
keymap("n", "<A-S-k>", ":resize -2<CR>", opts)
keymap("n", "<A-S-j>", ":resize +2<CR>", opts)
keymap("n", "<A-S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-S-l>", ":vertical resize +2<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Tabs
keymap('n', '[t', ':tabprevious<CR>', opts)
keymap('n', ']t', ':tabnext<CR>', opts)
keymap('n', '[T', ':tabfirst<CR>', opts)
keymap('n', ']T', ':tablast<CR>', opts)
