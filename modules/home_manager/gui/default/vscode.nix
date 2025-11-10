{
  pkgs,
  inputs,
  nixos-config,
  ...
}:
let
  extensions = inputs.vscode-extensions.extensions.${nixos-config.nixpkgs.hostPlatform.system};
in
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

      extensions = with extensions.vscode-marketplace; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
        ms-python.python
        tamasfe.even-better-toml
        ms-vscode.live-server
        bradlc.vscode-tailwindcss
        james-yu.latex-workshop
        ms-azuretools.vscode-docker
        theqtcompany.qt-qml
        theqtcompany.qt-core
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
        git.autofetch = true;
        qt-qml.qmlls.useQmlImportPathEnvVar = true;
        qt-qml.qmlls.customExePath = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
        qt-qml.doNotAskForQmllsDownload = true;
        editor.tabSize = 2;
        
      };
    };
  };
}
