{ ... }:

{
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
