return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree filesystem reveal float<CR>', desc = 'NeoTree filesystem float', silent = true },
    { '-', ':Neotree filesystem show reveal toggle left<CR>', desc = 'NeoTree filesystem left', silent = true },
    { '<leader>b', ':Neotree buffers reveal float<CR>', desc = 'NeoTree show buffers', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
