{
  home-manager.users.yuugen = {
    imports = [];

    home = rec {
      username = "yuugen";
      homeDirectory = "/home/${username}";
      stateVersion = "23.11";
    };
  };
}
