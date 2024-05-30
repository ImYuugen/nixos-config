[
  ./gaming
  ./git
  ./files
  ./firefox
  ./kitty
  ./media
  ./obs-studio
  ./sound
  ./spotify
  ./utils
  ./vpn
  ./yt-dlp
  (import ./utils/macchina.nix)
] ++ (import ./communications)
++ (import ./dev)
++ (import ./editors)
++ (import ./productivity)
++ (import ./shells)
