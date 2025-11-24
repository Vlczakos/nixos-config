{
  pkgs,
  inputs,
  ...
}:
let
  extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
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

      extensions = with extensions; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
        ms-python.python
        tamasfe.even-better-toml
        ms-vscode.live-server
        bradlc.vscode-tailwindcss
        james-yu.latex-workshop
        ms-azuretools.vscode-docker
        slint.slint
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
        slint.lspBinaryPath = pkgs.lib.getExe pkgs.slint-lsp;
        "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
        latex-workshop.formatting.latex = "tex-fmt";
        "[latex]".editor.wordWrap = "on";
      };
    };
  };
}
