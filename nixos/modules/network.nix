{ lib, config, ... }:

{
  imports = [
    ./submodules/wireguard-reiwa.nix
    ./submodules/wireguard-satori.nix
  ];

  reiwa.enable = true;
  satori.enable = lib.mkDefault false;

  systemd.network.wait-online.enable = false;
  networking = {
    hostName = "hanabi";
    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "stable-ssid";
        scanRandMacAddress = true;
      };
      ethernet.macAddress = "random";
    };

    stevenblack = {
      enable = true;
      block = [ "fakenews" ];
    };

    firewall = {
      allowPing = false;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
