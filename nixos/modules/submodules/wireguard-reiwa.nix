{ lib, config, ... }:

{
  options.reiwa.enable = lib.mkEnableOption "Enable Reiwa";

  config = lib.mkIf config.reiwa.enable {
    networking.wg-quick.interfaces.reiwa = {
      privateKeyFile = "/home/topenpe/documents/amnezia/keys/awg-hanabi.sec";
      dns = [ "1.1.1.1" ];
      address = [ "10.73.105.2" ];

      peers = [{
        publicKey = "pDnqX3+wfdG6shkrWc9SzaTppf2aMk+Vz5Uqb8q5kFw=";
        endpoint = "140.82.8.151:443";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
      }];
    };
  };
}
