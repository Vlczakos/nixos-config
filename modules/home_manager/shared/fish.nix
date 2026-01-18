{ config, ... }:

{
  home.shell.enableFishIntegration = true;

  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = {
        body = "# echo \"Starting fish...\"";
      };

      fish_command_not_found = {
        body = "
          echo $argv[1]: command not found 
        ";
      };

      fish_prompt = {
        body = "
            set -l last_status $status
    
            prompt_login
        
            echo -n ':'
        
            # PWD
            set_color $fish_color_cwd
            echo -n (prompt_pwd)
            set_color normal
        
            set -q __fish_git_prompt_showdirtystate
            or set -g __fish_git_prompt_showdirtystate 1
            set -q __fish_git_prompt_showuntrackedfiles
            or set -g __fish_git_prompt_showuntrackedfiles 1
            set -q __fish_git_prompt_showcolorhints
            or set -g __fish_git_prompt_showcolorhints 1
            set -q __fish_git_prompt_color_untrackedfiles
            or set -g __fish_git_prompt_color_untrackedfiles yellow
            set -q __fish_git_prompt_char_untrackedfiles
            or set -g __fish_git_prompt_char_untrackedfiles '?'
            set -q __fish_git_prompt_color_invalidstate
            or set -g __fish_git_prompt_color_invalidstate red
            set -q __fish_git_prompt_char_invalidstate
            or set -g __fish_git_prompt_char_invalidstate '!'
            set -q __fish_git_prompt_color_dirtystate
            or set -g __fish_git_prompt_color_dirtystate blue
            set -q __fish_git_prompt_char_dirtystate
            or set -g __fish_git_prompt_char_dirtystate '*'
            set -q __fish_git_prompt_char_stagedstate
            or set -g __fish_git_prompt_char_stagedstate '✚'
            set -q __fish_git_prompt_color_cleanstate
            or set -g __fish_git_prompt_color_cleanstate green
            set -q __fish_git_prompt_char_cleanstate
            or set -g __fish_git_prompt_char_cleanstate '✓'
            set -q __fish_git_prompt_color_stagedstate
            or set -g __fish_git_prompt_color_stagedstate yellow
            set -q __fish_git_prompt_color_branch_dirty
            or set -g __fish_git_prompt_color_branch_dirty red
            set -q __fish_git_prompt_color_branch_staged
            or set -g __fish_git_prompt_color_branch_staged yellow
            set -q __fish_git_prompt_color_branch
            or set -g __fish_git_prompt_color_branch green
            set -q __fish_git_prompt_char_stateseparator
            or set -g __fish_git_prompt_char_stateseparator '⚡'
            fish_vcs_prompt '|%s'
            echo

            echo -n '➤ '
            set_color normal
          ";
      };
    };

    interactiveShellInit =
      let
        c = config.lib.stylix.colors;
      in
      ''
        set -g fish_color_normal ${c.base05}

        set -g fish_color_command ${c.base0B}
        set -g fish_color_param ${c.base0D}
        set -g fish_color_keyword ${c.base0E}
        set -g fish_color_quote ${c.base0A}
        set -g fish_color_redirection ${c.base0C}
        set -g fish_color_error ${c.base08}

        set -g fish_color_comment ${c.base03}
        set -g fish_color_selection --background=${c.base02}
        set -g fish_color_search_match --background=${c.base02}
        set -g fish_color_operator ${c.base0C}
        set -g fish_color_escape ${c.base0C}
        set -g fish_color_autosuggestion ${c.base03}

        set -g fish_pager_color_prefix ${c.base0C} --bold
        set -g fish_pager_color_completion ${c.base05}
        set -g fish_pager_color_description ${c.base03}
        set -g fish_pager_color_progress ${c.base0C}
      '';
  };

  stylix.targets.fish.enable = false;
}
