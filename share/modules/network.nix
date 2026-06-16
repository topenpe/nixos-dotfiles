{ ... }:

{
  # All the networking is set up here:
  imports = [
    ./submodules/wireguard-reiwa.nix
  ];

  reiwa.enable = true; # Just my VPN config

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

    firewall = {
      # Add ports to open if necessary
      allowPing = false;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
