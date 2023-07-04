{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ macchina ];

  home.file.".config/macchina/macchina.toml".text = ''
    interface = "wlan0"

    long_uptime = true

    physical_cores = true
    memory_percentage = true
    disk_space_percentage = true

    # theme = ???

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
