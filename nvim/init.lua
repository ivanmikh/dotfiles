vim.loader.enable()

-- Leader key
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("user.options")
require("user.keymaps")
require("user.autocmd")
require("user.manager")
require("user.neovide")
