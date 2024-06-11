# My NixOS configuration ❄️
This is my daily driver on nixos

**Cool stuff:**
- (almost) Fully declarative
- Modular
- Optional Secure Boot support
- Integrated git hooks
<br>

**Apps:**
- WE: Hyprland 💧
  - Lockscreen: Hyprlock
  - Launcher: Rofi-wayland
  - Notifications: Mako
  - Wallpaper: Hyprpaper
- Terminal: Wezterm 💲
- Shell: Fish 🐟
- Editor: Helix 🧬
- Browser: Firefox 🦊
- Gaming:
  - Steam (with proton-ge)
  - Lutris
  - Prism launcher
  - Retroarch
- Other useful apps:
  - Vesktop
  - Mpv
  - OBS
  - Spotify

## Structure
- `flake.nix` Entry point, devshells, pre-commits and formatters.
- `pkgs` Self defined packages.
- `home` All users live there, this is where home-manager confs are.
  - `shared` Packages common to users.
  - `yuugen` Me :D
- `hosts` A host represents a machine.
  - `shared` Common configurations that do not depend on hardware.
  - `omen` My daily driver, an :sparkles: OMEN 15-en1027nf :sparkles:

## Installation
1) Enable [flakes](https://wiki.nixos.org/wiki/Flakes)
2) Clone this repo
3) Create yourself a host, with `default.nix` and `hardware.nix` (should be `/etc/nixos/hardware-configuration.nix`)
4) Create your user, import whichever modules you wish
5) `$ nixos-rebuild boot --flake .#<your host>`
6) Reboot
7) Enjoy

## Contributing
If you wish to improve on this config (Thank you !), you may open pull requests describing what you want to do.
Below are some things that are top priority to me (unordered)

## TODOs
- [ ] Options based module system
- [ ] More ricing
  - [ ] Defining a palette
  - [ ] Ags
  - [ ] Hyprland
  - [ ] Lock screens
  - [ ] Notifications
  - [ ] Rofi
  - [ ] Make it declarative
- [ ] Security
  - [ ] Disk encryption
  - [ ] Secrets
- [ ] Isolate home-manager from system so you don't rebuild each time

## Resources
I took inspiration from those:
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config/)
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [ja1den/_](https://gitlab.com/ja1den/_)
- [Nix PIE](https://gitlab.cri.epita.fr/cri/infrastructure/nixpie)
