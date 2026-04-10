{ pkgs, lib, scripts }:
let
  shader_path = ./shaders/blue_light.frag;
in
{
  settings = {
    "$mainMod" = "SUPER";

    bind = [
      "$mainMod, T, exec, kitty"
      "$mainMod, E, exec, thunar"
      "$mainMod, B, exec, brave"
      "$mainMod, C, exec, codium"
      "$mainMod, P, exec, kitty ${lib.getExe pkgs.python3}"
      "$mainMod, O, exec, okular"
      "$mainMod, X, exec, xournalpp"
      "$mainMod, L, exec, hyprlock"

      "$mainMod, Q, killactive"
      "$mainMod, M, fullscreen"
      "$mainMod, F, togglefloating"
      "$mainMod, S, togglesplit"
      "$mainMod, G, togglegroup"
      "$mainMod, Escape, exit"

      "CONTROL, Escape, exec, kitty btop"
      "CONTROL+SHIFT, Escape, exec, killall .waybar-wrapped || waybar"
      ", Print, exec, ${lib.getExe pkgs.hyprshot} -m active -m window --output-folder ~/Pictures/Screenshots --filename $(date +'%Y-%m-%d_%H-%M-%S.png')"
      "$mainMod, Print, exec, ${lib.getExe pkgs.hyprshot} -m region --output-folder ~/Pictures/Screenshots --filename $(date +'%Y-%m-%d_%H-%M-%S.png')"
      "$mainMod, J, exec, ${pkgs.kitty}/bin/kitten panel --edge=center --layer=overlay --focus-policy=exclusive -o background_opacity=1.0 -o font_size=20 ${lib.getExe pkgs.cmatrix} -u 6 -a -b -s"

      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod, A, togglespecialworkspace"
      "$mainMod SHIFT, A, movetoworkspacesilent, special"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindl = [
      ", XF86AudioMute, exec, ${scripts.volume} t"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"

      "$mainMod, K, exec, hyprctl dispatch dpms off"
      "$mainMod SHIFT, K, exec, hyprctl dispatch dpms on"
      ",switch:on:Lid Switch,exec, hyprctl dispatch dpms off && hyprlock"
      ",switch:off:Lid Switch,exec, hyprctl dispatch dpms on"

      "$mainMod, N, exec, ${scripts.shader} toggle ${shader_path}"
      "$mainMod, Space, exec, ${scripts.keyboard_toggle}"
    ];

    bindel = [
      ", XF86MonBrightnessUp, exec, ${scripts.brightness} i"
      ", XF86MonBrightnessDown, exec, ${scripts.brightness} d"
      ", XF86AudioLowerVolume, exec, ${scripts.volume} d"
      ", XF86AudioRaiseVolume, exec, ${scripts.volume} i"
    ];

    gesture = [ "3, horizontal, workspace" ];
  };

  extraConfig = ''
    bind = $mainMod, delete, exec, hyprctl dispatch dpms off
    bind = $mainMod, delete, submap, cheat

    submap = cheat
    bind =  , mouse:272, exec, hyprctl dispatch dpms on
    bindr = , mouse:272, exec, hyprctl dispatch dpms off

    bind = $mainMod, delete, exec, hyprctl dispatch dpms on
    bind = $mainMod, delete, submap, reset
    bind = , catchall, exec, 
    submap = reset
  '';
}