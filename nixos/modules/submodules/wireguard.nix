{ lib, config, ... }:

{
  options.wg.enable = lib.mkEnableOption "Enable Wireguard configuration";

  config = lib.mkIf config.wg.enable {
    networking.wg-quick.interfaces.hanabi = {
      privateKeyFile = "/home/topenpe/documents/keys/hanabi-private.key";
      dns = [ "1.1.1.1" ];
      address = [ "10.73.105.2/32" "fd41:ce44:b4c9:44ca::2/128" ];

      peers = [{
        publicKey = "asu62YSm2ooTtj2PSPohXjyEAKd4Z8ShkCUApo6LORc=";
        endpoint = "104.225.141.162:2256";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
      }];
    };
  };
}
