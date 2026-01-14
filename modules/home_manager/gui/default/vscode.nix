{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.fish.shellAliases.code = "codium";

  home.file.".vscodium-server/extensions" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.vscode-oss/extensions";
    force = true;
  };

  stylix.targets.vscode.enable = false;

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions =
        with pkgs.vscode-marketplace;
        [
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
        ]
        ++ (with pkgs.open-vsx; [
          jeanp413.open-remote-ssh
        ]);

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

        workbench.colorTheme = "Default Dark Modern";
        "workbench.colorCustomizations" = {
          "editor.background" = "#${config.lib.stylix.colors.base00}";
          "sideBar.background" = "#${config.lib.stylix.colors.base00}";
          "sideBar.border" = "#${config.lib.stylix.colors.base01}";
          "activityBar.background" = "#${config.lib.stylix.colors.base00}";
          "activityBar.border" = "#${config.lib.stylix.colors.base01}";
          "editorGroupHeader.tabsBackground" = "#${config.lib.stylix.colors.base00}";
          "tab.activeBackground" = "#${config.lib.stylix.colors.base00}";
          "tab.inactiveBackground" = "#${config.lib.stylix.colors.base00}";
          "statusBar.background" = "#${config.lib.stylix.colors.base00}";
          "statusBar.border" = "#${config.lib.stylix.colors.base01}";
          "titleBar.activeBackground" = "#${config.lib.stylix.colors.base00}";
          "titleBar.activeForeground" = "#${config.lib.stylix.colors.base05}";

          "activityBar.foreground" = "#${config.lib.stylix.colors.base0D}";
          "statusBar.foreground" = "#${config.lib.stylix.colors.base0D}";
          "tab.activeBorder" = "#${config.lib.stylix.colors.base0D}";
          "editorCursor.foreground" = "#${config.lib.stylix.colors.base0D}";
          "list.activeSelectionForeground" = "#${config.lib.stylix.colors.base0D}";
        };
      };
    };
  };
}
