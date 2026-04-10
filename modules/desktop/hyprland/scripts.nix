{ lib, pkgs }:
{
  shader = lib.getExe (
    pkgs.writeShellScriptBin "hyprland_screen_shader" ''
      turn_on() {
        if [ "$2" == "on" ]; then hyprctl keyword debug:damage_tracking off; fi
        hyprctl keyword decoration:screen_shader "$1"
      }
      turn_off() {
        hyprctl keyword debug:damage_tracking on
        hyprctl keyword decoration:screen_shader ""
      }
      case $1 in
        toggle)
          if [ "$(hyprctl getoption decoration:screen_shader | grep str)" == "str: $2" ]; then turn_off
          else turn_on "$2" "$3"; fi ;;
        on) turn_on "$2" "$3" ;;
        off) turn_off ;;
      esac
    ''
  );

  volume = lib.getExe (
    pkgs.writeShellScriptBin "volume_script" ''
      case $1 in
        t) pamixer -t ;;
        i) pamixer --allow-boost -i 1 ;;
        d) pamixer --allow-boost -d 1 ;;
      esac
      dunstify -h string:x-dunst-stack-tag:volume -t 1000 "$(pamixer --get-volume-human)"
    ''
  );

  brightness = lib.getExe (
    pkgs.writeShellScriptBin "brightness_script" ''
      case $1 in
        i) brightnessctl set +5% ;;
        d) brightnessctl set 5%- ;;
      esac
      curr=$(brightnessctl get)
      max=$(brightnessctl max)
      dunstify -h string:x-dunst-stack-tag:brightness -t 1000 "$((curr * 100 / max))%"
    ''
  );

  keyboard_toggle = lib.getExe (
    pkgs.writeShellScriptBin "keyboard_toggle_script" ''
      keyboards=$(hyprctl devices | grep -A7 "Keyboard at" | grep -B6 "main: yes" | awk 'NR % 8 == 1' | awk '{print $1}')
      for kbd in $keyboards; do hyprctl switchxkblayout "$kbd" next; done
      active=$(hyprctl devices | grep -A3 "$keyboards" | grep "active keymap:" | awk '{$1=""; $2=""; sub(/^  */, ""); print}')
      dunstify -h string:x-dunst-stack-tag:keyboard_layout -t 1000 "$active"
    ''
  );
}
