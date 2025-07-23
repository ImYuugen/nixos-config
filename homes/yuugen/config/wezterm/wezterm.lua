local Config = require("config")

return Config:init()
  :append(require("config.appearance"))
  :append(require("config.bindings"))
  -- FIXME: Temporary, manage themes with hm
  :append({ color_scheme = "Everforest Dark Medium (Gogh)" })
  .options
