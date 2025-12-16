{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        8080 # mc map
        25565 # mc server
      ];
      allowedUDPPorts = [
        24454 # mc voice chat
      ];
    };
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      server = {
        enable = true;
        package = (
          pkgs.minecraftServers.fabric-1_21_10.override (prev: {
            jre_headless = pkgs.temurin-bin-25;
          })
        );

        jvmOpts = "-Xms10G -Xmx10G -XX:+UseZGC -XX:+UseCompactObjectHeaders -Dfabric.addMods=mods";

        serverProperties = {
          allow-flight = false;
          difficulty = "hard";
          motd = "Ještě víc TOP Minecraft Server :D §b§d§f§d§b";
          spawn-protection = 0;
          server-port = 25565;
          max-players = 67;
          simulation-distance = 8;
          view-distance = 8;
          white-list = true;
          hide-online-players = true;
          enable-command-block = true;
          pause-when-empty-seconds = -1;
          sync-chunk-writes = false;
          enforce-secure-profile = false;
          network-compression-threshold = 128;
          function-permission-level = 3;
        };
      };
    };
  };

  # services.borgbackup.jobs."minecraft-server-backup" = {
  #   paths = [ "/srv/minecraft/server" ];
  #   repo = "/srv/minecraft/server-backup";
  #   user = "minecraft";
  #   compression = "zstd";
  #   encryption.mode = "none";

  #   prune.keep = {
  #     within = "2d";
  #     weekly = 3;
  #   };

  #   startAt = [
  #     "00:00"
  #     "06:00"
  #     "12:00"
  #     "18:00"
  #   ];

  #   preHook = ''
  #     ${lib.getExe pkgs.tmux} -S /run/minecraft/server.sock send-keys "save-off" C-m
  #     ${lib.getExe pkgs.tmux} -S /run/minecraft/server.sock send-keys "save-all" C-m
  #     sleep 10
  #   '';

  #   postHook = ''
  #     ${lib.getExe pkgs.tmux} -S /run/minecraft/server.sock send-keys "save-on" C-m
  #   '';
  # };
}
