local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "VeryLazy",
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  require("nvim-treesitter.configs").setup {
    auto_install = true,
    -- put the language you want in this array
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
    },
    ignore_install = { "" },
    modules = {},
    sync_install = false,
    highlight = {
      enable = true,
      -- disable = { "markdown" },
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    ts_context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return M
