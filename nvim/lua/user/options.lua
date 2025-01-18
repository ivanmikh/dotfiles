-- Enable mouse
vim.opt.mouse = 'a'

-- Set colorscheme
vim.cmd.colorscheme 'wombat256'

-- Show current mode
vim.opt.showmode = true

-- Sync clipboards
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Show line numbers
vim.opt.number = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '-', space = '·', eol = '¬' }

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Indent control
vim.opt.expandtab = true  -- insert spaces rather than tabs for <tab>
vim.opt.smarttab = true   -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.tabstop = 4       -- the visible width of tabs
vim.opt.softtabstop = 4   -- edit as if the tabs are 4 characters wide
vim.opt.shiftwidth = 4    -- number of spaces to use for indent and unindent
vim.opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- Search control
vim.opt.shortmess = 'filnxtToOFc' -- show search count
vim.opt.showmatch = true  -- show matching brackets.
vim.opt.ignorecase = true -- do case insensitive matching
vim.opt.smartcase = true  -- do smart case matching
vim.opt.incsearch = true  -- incremental search
vim.opt.autowrite = true  -- automatically save before commands like :next and :make
vim.opt.inccommand = 'split' -- preview substitutions live
vim.opt.path = '**'  -- recursive search
vim.opt.wildmenu = true -- nice way to show search results

-- Scroll bind horizaontally
vim.opt.scrollopt = 'hor,ver,jump'

-- Sort is affecting only: directories on the top, files below
vim.g.netrw_sort_sequence = '[\\/]$,*'
vim.g.netrw_banner = false

-- TODO: move to plugins init
vim.g.github_enterprise_urls = { 'https://github.schneider-electric.com' }
