{ lib, config, pkgs, ... }:
let cfg = config.services.rtorrent; in
{
  options.rtorrent-service.enable = lib.mkEnableOption "Enable rtorrent as a serivce";

  config = lib.mkIf config.rtorrent-service.enable {
    services.rtorrent = {
      enable = true;
      dataPermissions = "0755";
      downloadDir = "/home/topenpe/downloads/rtorrent";
      openFirewall = true;
      # rpcSocket = "/home/topenpe/build/rtorrent.socket";
      # configText = ''
      #   system.daemon.set = true
      #   network.scgi.open_local = (cat,(session.path),rpc.socket)
      #   execute.nothrow = chmod,770,(cat,(session.path),rpc.socket)
      # '';
    };

    # cfg now builds own systemd service
    # systemd.services.rtorrent = {
    #   description = "rtorrent daemon";
    #   after = [ "network.target" ];
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig = {
    #     User = cfg.user;
    #     Group = cfg.group;
    #     WorkingDirectory = "/var/lib/rtorrent";
    #     ExecStart = "${pkgs.rtorrent}/bin/rtorrent";
    #     Restart = "on-failure";
    #   };
    # };

    # systemd.tmpfiles.rules = [
    #   "d /var/lib/rtorrent 0755 ${cfg.user} ${cfg.group} -"
    #   "d ${toString cfg.downloadDir} 0755 ${cfg.user} ${cfg.group} -"
    #   "d ${toString cfg.sessionDir} 0755 ${cfg.user} ${cfg.group} -"
    # ];
  };
}
