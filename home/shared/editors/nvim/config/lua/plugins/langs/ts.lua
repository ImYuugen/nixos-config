local util = require("lspconfig.util")
local bin = "typescript-language-server"


if vim.fn.executable(bin) ~= 1 then
  return
end

local root_files = {
  "tsconfig.json",
  "jsconfig.json",
  "package.json",
  ".git",
}

require("lspconfig").ts_ls.setup({
  init_options = {
    plugins = {},
  },
})
