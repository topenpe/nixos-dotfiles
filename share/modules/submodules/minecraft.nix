{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.minecraft.enable = lib.mkEnableOption "Enable Minecraft server configuration";

  config = lib.mkIf config.minecraft.enable {
    services.minecraft-server = {
      enable = true;
      eula = true;
      package = pkgs.papermcServers.papermc-1_19_2;
      openFirewall = true;
      declarative = true;
      jvmOpts = "-Xms512M -Xmx4096M -XX:SoftMaxHeapSize=3G -XX:+UnlockExperimentalVMOptions -XX:+UseZGC";
      serverProperties = {
        allow-flight = true;
        allow-nether = true;
        broadcast-console-to-ops = true;
        broadcast-rcon-to-ops = true;
        difficulty = "hard";
        enable-command-block = false;
        enable-jmx-monitoring = false;
        enable-query = false;
        enable-rcon = false;
        enable-status = true;
        enforce-secure-profile = true;
        enforce-whitelist = false;
        entity-broadcast-range-percentage = 100;
        force-gamemode = false;
        function-permission-level = 2;
        gamemode = "survival";
        generate-structures = true;
        hardcore = false;
        hide-online-players = false;
        level-name = "gdenibud";
        level-type = "minecraft\:normal";
        max-chained-neighbor-updates = 1000000;
        max-players = 10;
        max-tick-time = 180000;
        max-world-size = 29999984;
        motd = "The Almighty’s office in Cuban";
        network-compression-threshold = 256;
        online-mode = false;
        op-permission-level = 4;
        player-idle-timeout = 0;
        prevent-proxy-connections = false;
        previews-chat = false;
        pvp = true;
        "query.port" = 25565;
        rate-limit = 0;
        require-resource-pack = false;
        server-port = 1337;
        simulation-distance = 16;
        spawn-animals = true;
        spawn-monsters = true;
        spawn-npcs = true;
        spawn-protection = 16;
        sync-chunk-writes = true;
        use-native-transport = true;
        view-distance = 20;
        white-list = false;
      };
    };
  };
}
