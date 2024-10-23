{ lib, config, ... }:

{
  options.wg.enable = lib.mkEnableOption "Enable Wireguard configuration";

  config = lib.mkIf config.wg.enable {
    networking.wg-quick.interfaces.hanabi = {
      privateKeyFile = "/home/topenpe/documents/keys/wireguard/satori";
      dns = [ "1.1.1.1" ];
      address = [ "10.0.0.2" ];

      peers = [{
        publicKey = "L8jkKPNWkHZ8eEUqsYfuRceSnFAvJhDiKSwZVaxAFXU=";
        endpoint = "45.63.120.144:443";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
      }];
    };
  };
}
