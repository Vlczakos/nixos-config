{ pkgs, ... }:
let
  isX86 = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
in
{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = isX86;
      cudaSupport = isX86;
    };
    settings = {
      vim_keys = true;
      rounded_corners = true;
      proc_tree = false;
      show_gpu_info = "on";
      show_uptime = true;
      show_coretemp = true;
      cpu_sensor = "auto";
      show_disks = true;
      only_physical = true;
      io_mode = true;
      io_graph_combined = false;
    };
  };
}
