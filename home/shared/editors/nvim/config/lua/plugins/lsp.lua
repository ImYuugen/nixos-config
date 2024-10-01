return {
  {
    "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    after = function(_)
      local opts = {
        diagnostics = {
            underline = true,
            severity_sort = true,
        },
        inlay_hints = { enabled = true, },
        autoformat = true,
        servers = {},
      }
      local servers = opts.servers
      for server, server_opts in pairs(servers) do
        require("lspconfig")[server].setup(server_opts)
      end
    end
  },

  {
    "none-ls",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local none_ls = require("none-ls")
    end
  }
}
