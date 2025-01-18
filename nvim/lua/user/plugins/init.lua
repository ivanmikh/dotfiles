return {
  -- Neovim lua libraries that all plugins require,
  -- We don't actually interact with these plugins.
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  'tpope/vim-sleuth',     -- Detect tabstop and shiftwidth automatically
  'tpope/vim-commentary', -- Comments stuff out with gc(c)
  'tpope/vim-repeat',     -- Extends '.' to plugins
  'tpope/vim-fugitive',   -- Git plugin
  'tpope/vim-unimpaired', -- ][ shortcuts
  'tpope/vim-rhubarb',    -- GitHub commands (GBrowse)

  'airblade/vim-gitgutter', -- Git diff in sign column
  'junegunn/gv.vim',        -- Git commit history
  'majutsushi/tagbar',      -- Tag bar

    -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  require("user.plugins.lsp"),
  require("user.plugins.autocompletion"),
  require("user.plugins.mini"),
  require("user.plugins.telescope"),
  require("user.plugins.neo-tree"),

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
