# https://github.com/emmanuelrosa/erosanix/blob/master/modules/protonvpn.nix

{ config, lib, ... }:

let
  cfg = config.modules.networking.protonvpn;
in
{
  options.modules.networking.protonvpn = {
    enable = lib.mkEnableOption "ProtonVPN (Wireguard)";

    autostart = lib.mkOption {
      default = false;
      example = "true";
      type = lib.types.bool;
      description = "Automatically set up ProtonVPN when NixOS boots.";
    };

    interface = {
      name = lib.mkOption {
        default = "protonvpn";
        example = "wg0";
        type = lib.types.str;
        description = "The name of the Wireguard network interface to create. Go to https://account.protonmail.com/u/0/vpn/WireGuard to create a Linux Wireguard certificate and download it. You'll need it's content to set the options for this module.";
      };

      ip = lib.mkOption {
        default = "10.2.0.2/32";
        example = "10.2.0.2/32";
        type = lib.types.str;
        description = "The IP address of the interface. See your Wireguard certificate.";
      };

      port = lib.mkOption {
        default = 51820;
        example = 51820;
        type = lib.types.port;
        description = "The port number of the interface.";
      };

      privateKeyFile = lib.mkOption {
        example = "/root/secrets/protonvpn";
        type = lib.types.path;
        description = "The path to a file containing the private key for this interface/peer. Only root should have access to the file. See your Wireguard certificate.";
      };

      dns = {
        enable = lib.mkOption {
          default = true;
          example = "true";
          type = lib.types.bool;
          description = "Enable the DNS provided by ProtonVPN";
        };

        ip = lib.mkOption {
          default = "10.2.0.1";
          example = "10.2.0.1";
          type = lib.types.str;
          description = "The IP address of the DNS provided by the VPN. See your Wireguard certificate.";
        };
      };
    };

    endpoint = {
      publicKey = lib.mkOption {
        example = "23*********************************************=";
        type = lib.types.str;
        description = "The public key of the VPN endpoint. See your Wireguard certificate.";
      };

      ip = lib.mkOption {
        example = "48.1.3.4";
        type = lib.types.str;
        description = "The IP address of the VPN endpoint. See your Wireguard certificate.";
      };

      port = lib.mkOption {
        default = 51820;
        example = 51820;
        type = lib.types.port;
        description = "The port number of the VPN peer endpoint. See your Wireguard certificate.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking.wg-quick.interfaces."${cfg.interface.name}" = {
      autostart = cfg.autostart;
      dns = if cfg.interface.dns.enable then [ cfg.interface.dns.ip ] else [ ];
      privateKeyFile = cfg.interface.privateKeyFile;
      address = [ cfg.interface.ip ];
      listenPort = cfg.interface.port;

      peers = [
        {
          publicKey = cfg.endpoint.publicKey;
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "${cfg.endpoint.ip}:${builtins.toString cfg.endpoint.port}";
        }
      ];
    };
  };
}
