function flakebuild --wraps='doas nixos-rebuild boot --flake .#' --description 'Builds the flake in the current directory'
    doas nixos-rebuild boot --flake .# $argv

end
