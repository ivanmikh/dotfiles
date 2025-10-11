return {
  -- Neovim lua libraries that all plugins require,
  -- We don't actually interact with these plugins.
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  'tpope/vim-fugitive',   -- Git plugin
  'airblade/vim-gitgutter', -- Git diff in sign column
  'junegunn/gv.vim',        -- Git commit history
  'tpope/vim-rhubarb',    -- GitHub commands (GBrowse)

  'tpope/vim-sleuth',     -- Detect tabstop and shiftwidth automatically
  'tpope/vim-unimpaired', -- ][ shortcuts

  require("user.plugins.autocompletion"),
  require("user.plugins.comment"),
  require("user.plugins.lsp"),
  require("user.plugins.lualine"),
  require("user.plugins.markdown-toc"),
  require("user.plugins.neo-tree"),
  require("user.plugins.outline"),
  require("user.plugins.telescope"),
  require("user.plugins.todo-comments"),
  require("user.plugins.treesitter"),
  require("user.plugins.which-key"),

  --require("user.plugins.mini"),
  --require("user.plugins.gitsigns"),
  --require("user.plugins.neogit"),

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
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
