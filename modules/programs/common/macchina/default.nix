{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ macchina ];

  home.file.".config/macchina/macchina.toml".text = ''
    show = [
      "OperatingSystem",
      "Distribution",
      "WindowManager",
      "Uptime",
      "Processor",
      "GPU",
      "Battery",
      "Memory",
      "DiskSpace"
    ]
  '';
  home.file.".config/macchina/themes".source = ./themes;
}
