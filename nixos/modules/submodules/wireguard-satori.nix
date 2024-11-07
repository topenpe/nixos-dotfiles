{ lib, config, ... }:

{
  options.satori.enable = lib.mkEnableOption "Enable Satori";

  config = lib.mkIf config.satori.enable {
    networking.wg-quick.interfaces.satori = {
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
