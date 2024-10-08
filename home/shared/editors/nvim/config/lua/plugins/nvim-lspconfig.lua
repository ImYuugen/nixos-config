return {
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
    for server, server_opts in pairs(opts.servers) do
      require("lspconfig")[server].setup(server_opts)
    end
  end
}
