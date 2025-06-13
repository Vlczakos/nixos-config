{ pkgs, lib, ... }:
let
  davinci_script = pkgs.writeShellScriptBin "davinci-resolve" ''
    ROC_ENABLE_PRE_VEGA=1 RUSTICL_ENABLE=amdgpu,amdgpu-pro,radv,radeon DRI_PRIME=1 QT_QPA_PLATFORM=xcb ${lib.getExe pkgs.davinci-resolve}
  '';
in
{
  home.packages = [
    davinci_script
  ];
}
