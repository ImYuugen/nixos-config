function get_if_available(name, opts)
   local ok, colorscheme = pcall(require, name)
   if ok then
      colorscheme.setup(opts)
      return name
   end

   local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
   if vim_ok then
      return name
  end

  return "default"
end

--local colorscheme = get_if_available("catppuccin")
local colorscheme = get_if_available("rose-pine")
return colorscheme
