function flakeswitch --wraps='doas nixos-rebuild switch --flake .#' --description 'Switches to the flake in the current directory'
    doas nixos-rebuild switch --flake .# $argv

end
