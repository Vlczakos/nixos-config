{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];

  programs.fish.shellAliases.code = "codium";

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
        ms-python.python
        tamasfe.even-better-toml
        ms-vscode.live-server
        bradlc.vscode-tailwindcss
      ];

      userSettings = {
        nix = {
          enableLanguageServer = true;
          serverPath = "nixd";

          serverSettings.nixd = {
            formatting.command = "nixfmt";

            options = {
              nixos.expr = "(builtins.getFlake \"/nixos-config/flake.nix\").nixosConfigurations.nixos.options";
            };
          };
        };
        editor.minimap.enabled = false;
        chat.commandCenter.enabled = false;
        workbench.activityBar.location = "default";
      };
    };
  };
}