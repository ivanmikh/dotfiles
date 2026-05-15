local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
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
    'hrsh7th/cmp-nvim-lsp',
    "p00f/clangd_extensions.nvim",
  }
}

function M.config()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      -- Jump to the declaration of the word under your cursor.
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Find references for the word under your cursor.
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

      -- Jump to the implementation of the word under your cursor.
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      -- Jump to the type of the word under your cursor.
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

      -- Fuzzy find all the symbols in your current document.
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace.
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- Rename the variable under your cursor.
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Code format
      map('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat', { 'n', 'x' })

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

      -- Switch source/header (Clangd feature)
      map('gh', ':ClangdSwitchSourceHeader<CR>', '[G]oto [H]eader')

      -- Toggle inlay hints
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')

      -- Highlight references of the word under your cursor
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })

    end,
  })

  -- Change diagnostic symbols in the sign column (gutter)
  -- if vim.g.have_nerd_font then
  --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  --   local diagnostic_signs = {}
  --   for type, icon in pairs(signs) do
  --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
  --   end
  --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
  -- end
  local default_diagnostic_config = {
    signs = {
      text = {
        -- [x.ERROR] = icons.diagnostics.BoldError,
        -- [x.WARN] = icons.diagnostics.BoldWarning,
        -- [x.INFO] = icons.diagnostics.BoldInformation,
        -- [x.HINT] = icons.diagnostics.BoldHint,
      },
    },
    virtual_text = { prefix = "" },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  local capabilities = vim.tbl_deep_extend('force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  )

  for _, name in ipairs({ "pyright", "mesonlsp", "neocmake", "bashls", "lua_ls" }) do
    vim.lsp.config[name] = { capabilities = capabilities }
    vim.lsp.enable(name)
  end

  vim.lsp.config.rust_analyzer = {
    settings = {
      capabilities = capabilities,
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
        cargo = {
          allFeatures = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }
  vim.lsp.enable("rust_analyzer")

  vim.lsp.config.clangd = {
    capabilities = capabilities,
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
    init_options = {
      -- fallbackFlags = { '-std=c++17' },
    },
  }
  vim.lsp.enable("clangd")
end

return M
