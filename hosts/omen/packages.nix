{pkgsSet, ...}: {
  environment.systemPackages = with pkgsSet.stable; [
    acpi
    alsa-lib
    alsa-utils
    libnotify
    libva
    libva-utils
    mesa
    nvtopPackages.full
    p7zip
    rar
    sbctl
    unzip
    vaapiVdpau
    xdg-utils
    zip

    # Nvidia
    nvidia-vaapi-driver
    # AMD
    amdvlk
  ];
}
