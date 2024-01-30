return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    depedencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("util").has("nvim-cmp")
        end
      }
    },
    opts = {
      diagnostics = {
        underline = true,
        severity_sort = true,
      },
      inlay_hints = { enabled = true },
      autoformat = true,
      servers = {}, -- Set so it isn't nil
    },
    config = function(_, opts)
      local servers = opts.servers
      for server, server_opts in pairs(servers) do
        require("lspconfig")[server].setup(server_opts)
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = { { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
        ensure_installed = { }
    }, -- Set so it isn't nil
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh() then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require("null-ls")
    end
  }
}
