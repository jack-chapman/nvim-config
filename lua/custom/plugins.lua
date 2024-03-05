local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
      }
    },
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = "NonText",
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require('custom.configs.rust-tools').server.on_attach(client, bufnr)
            require('lsp-inlayhints').on_attach(client, bufnr)

            local wk = require('which-key')
            wk.register({
              -- ['<leader>ca'] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
              ['<leader>ta'] = { function() vim.cmd.RustLsp("testables") end, "Rust testables" },
            }, { mode = "n", buffer = bufnr })
          end,
          capabilities = require('custom.configs.rust-tools').server.capabilities
        }
      }
    end
  }
}

return plugins
