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
    interfaces.wlp4s0 = {
      useDHCP = false;
      ipv4.addresses = [ { address = "192.168.1.10"; prefixLength = 24; } ];
    };
    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "stable-ssid";
        scanRandMacAddress = true;
      };
      ethernet.macAddress = "random";
    };

    firewall = {
      allowPing = false;
      allowedTCPPorts = [ 2256 ];
      allowedUDPPorts = [ 2256 ];
    };
  };
}
