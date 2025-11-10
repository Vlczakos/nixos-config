{ pkgs, ... }:
{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;

    activeConfig = "/nixos-config/modules/home_manager/gui/default/quickshell";

    configs."." = ./quickshell;
  };

  home.sessionVariables = {
    QML_IMPORT_PATH = "${pkgs.quickshell}/lib/qt-6/qml:${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml";
  };
}