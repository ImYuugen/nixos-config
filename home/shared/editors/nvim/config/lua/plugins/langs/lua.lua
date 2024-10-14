local util = require("lspconfig.util")

local lsp_bin = "lua-language-server"

if vim.fn.executable(lsp_bin) ~= 1 then
  return
end

require("lspconfig").lua_ls.setup({
  autostart = true,
  cmd = { lsp_bin },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend(
      "force",
      client.config.settings.Lua,
      {
        runtime = { version = "LuaJIT", },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          },
        },
      }
    )
  end,
  settings = {
    Lua = {
      completion = {
        autoRequire = true,
        keywordSnippet = "Both",
      },
    }
  },
})

require("conform").formatters_by_ft.lua = {
  "stylua",
}
