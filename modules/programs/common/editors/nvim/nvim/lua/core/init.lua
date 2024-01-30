local M = { }

require("core.options")
require("core.lazy")
require("core.mappings")
require("core.autocmds")

M.icons = {
  diagnostics = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = "󰛩 ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  kinds = {
    Array = " ";
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = "󰡢 ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰡱 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰡱 ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = "󰆧 ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

return M
