{ config, ... }:

{
  services.emacs = {
    enable = true;
    client = {
      enable = true;
    };
  };

  home.file.".emacs.d" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
