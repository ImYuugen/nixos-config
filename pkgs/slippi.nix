{
  appimageTools,
  copyDesktopItems,
  fetchurl,
  makeDesktopItem,
  makeWrapper,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "slippi-launcher";
  version = "2.11.8";
  meta = {
    description = "Play Melee online !";
    homepage = "https://slippi.gg";
  };
  src = appimageTools.wrapType2 {
    inherit pname version;
    src = fetchurl {
      url = "https://github.com/project-slippi/slippi-launcher/releases/download/v${version}/Slippi-Launcher-${version}-x86_64.AppImage";
      hash = "sha256-8krtzo878nh6oMTUhyPJIa/RkkebqQckb4Mh2+9SaiU=";
    };
    nativeBuildInputs = [ makeWrapper ];
    extraInstallCommands = ''
      wrapProgram $out/bin/slippi-launcher \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
    '';
  };

  desktopItems = [
    (makeDesktopItem {
      name = "slippi-launcher";
      exec = "slippi-launcher";
      icon = "slippi-launcher";
      desktopName = "Slippi Launcher";
      comment = "The way to play Slippi Online and watch replays";
      type = "Application";
      categories = [ "Game" ];
      keywords = [
        "slippi"
        "melee"
      ];
    })
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp -r "$src/bin" "$out"
    runHook postInstall
  '';
  nativeBuildInputs = [ copyDesktopItems ];
}
