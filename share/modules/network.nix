{...}: {
  # All the networking is set up here:
  imports = [
  ];

  systemd.network.wait-online.enable = false;
  networking = {
    hostName = "anby";
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
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };
}
