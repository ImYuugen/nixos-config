local util = require("lspconfig.util")

local lsp_bin = "nil"

if vim.fn.executable(lsp_bin) ~= 1 then
  return
end

local root_files = {
  "flake.nix",
  "default.nix",
  "shell.nix",
  ".git",
}

local caps = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

require("lspconfig").nil_ls.setup({
  autostart = true,
  capabilities = caps,
  cmd = { lsp_bin },
  settings = {
    ["nil"] = {
      nix = {
        maxMemoryMB = 2048,
      },
    },
  },
})

require("conform").formatters_by_ft.nix = { "nix fmt" }
