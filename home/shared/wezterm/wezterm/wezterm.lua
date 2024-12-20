local Config = require("config")

return Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    .options
