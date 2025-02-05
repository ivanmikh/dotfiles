vim.loader.enable()

-- Leader key
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

require("user.options")
require("user.keymaps")
require("user.autocmd")
require("user.manager")
