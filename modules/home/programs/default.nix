{ ... }:

{
  browsers = import ./browsers { };
  communications = import ./communications { };
  direnv = import ./direnv.nix;
  editors = import ./editors { };
  media = import ./media { };
  production = import ./production { };
  shells = import ./shells { };
  terminals = import ./terminals { };
}
