{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      server = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_5;

        jvmOpts = "-Xms10G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1";

        serverProperties = {
          allow-flight = false;
          difficulty = "hard";
          motd = "Top Minecraft Server :D §b§d§f§d§b";
          spawn-protection = 0;
          server-port = 25565;
          max-players = 69;
          simulation-distance = 8;
          view-distance = 8;
          white-list = true;
          hide-online-players = true;
        };
      };
    };
  };


  services.borgbackup.jobs."minecraft-server-backup" = {
    paths = [ "/srv/minecraft/server" ];
    repo = "/srv/minecraft/server-backup";
    user = "minecraft";
    compression = "zstd";

    prune.keep = {
      within = "2d";
      weekly = 3;
    };
    
    startAt = [ "00:00" "06:00" "12:00" "18:00" ];

    preHook = ''
      tmux -S /run/minecraft/server.sock send-keys "save-off" C-m
      tmux -S /run/minecraft/server.sock send-keys "save-all" C-m
      sleep 10
    '';

    postHook = ''
      tmux -S /run/minecraft/server.sock send-keys "save-on" C-m
    '';
  };
}
