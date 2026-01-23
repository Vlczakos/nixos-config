{ pkgs, ... }:
let
  rbwssh-script = pkgs.writeShellScriptBin "rbwssh" ''
    if [ -n "$RBW_SSH_ITEM" ]; then
        ${pkgs.rbw}/bin/rbw get "$RBW_SSH_ITEM"
        exit 0
    fi

    if [ $# -lt 2 ]; then
        echo "Error: Not enough parameters"
        echo "Usage: rbwssh <bitwarden name> <ssh parameters>"
        exit 1
    fi

    ${pkgs.rbw}/bin/rbw unlock

    export RBW_SSH_ITEM="$1"

    export SSH_ASKPASS="$0"
    export SSH_ASKPASS_REQUIRE=force

    shift

    exec ssh "$@"
  '';

  rbwssh-fish-completions = pkgs.writeTextFile {
    name = "rbwssh-fish-completions";
    destination = "/share/fish/vendor_completions.d/rbwssh.fish";
    text = ''
      complete -c rbwssh -e

      complete -c rbwssh -n "__fish_is_nth_token 1" -f -a "(${pkgs.rbw}/bin/rbw ls 2>/dev/null)" -d "Bitwarden Item"

      complete -c rbwssh -n "not __fish_is_nth_token 1" -a "(
        set -l tokens (commandline -opc)
        set -l current (commandline -ct)

        if test (count \$tokens) -ge 2
            set -e tokens[1..2]
        else
            set tokens
        end

        complete -C\"ssh \$tokens \$current\"
      )"
    '';
  };

  rbwssh = pkgs.symlinkJoin {
    name = "rbwssh";
    paths = [
      rbwssh-script
      rbwssh-fish-completions
    ];
  };
in
{
  home.packages = [ rbwssh ];

  programs.rbw = {
    enable = true;
    settings = {
      email = "vlcek.david@outlook.cz";
      pinentry = pkgs.pinentry-tty;
    };
  };
}
