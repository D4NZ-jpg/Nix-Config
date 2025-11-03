{ pkgs, lib, ... }:
let
  inherit (lib) optionalString;

  # Starship transient prompt configuration
  # Note: Home Manager's starship module only supports transience for Fish shell
  # This implements zsh transience following the same patterns
  enableStarshipTransience = true;

  starshipTransientPrompt = ''
    # Transient prompt configuration for Starship (zsh)
    # Based on: https://starship.rs/advanced-config/#transient-prompt
    
    starship_transient_prompt_func() {
      starship module character
    }
    
    starship_transient_rprompt_func() {
      starship module time
    }
    
    # Enable transient prompt
    zle-line-init() {
      emulate -L zsh
      [[ $CONTEXT == start ]] || return 0
      while true; do
        zle .recursive-edit
        local -i ret=$?
        [[ $ret == 0 && $KEYS == $'\4' ]] || break
        [[ -o ignore_eof ]] || exit 0
      done
      local saved_prompt=$PROMPT
      local saved_rprompt=$RPROMPT
      PROMPT='$(starship_transient_prompt_func) '
      RPROMPT='$(starship_transient_rprompt_func)'
      zle .reset-prompt
      PROMPT=$saved_prompt
      RPROMPT=$saved_rprompt
      if ((ret)); then
        zle .send-break
      else
        zle .accept-line
      fi
      return ret
    }
    zle -N zle-line-init
  '';
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # History configuration
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    # Aliases
    shellAliases = {
      # LazyGit (zoxide already provides 'z' command via integration)
      lz = "lazygit";
      # Common shortcuts
      la = "ls -la";
      ".." = "cd ..";
      "nix-switch" = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };

    # Enable vim mode
    defaultKeymap = "viins";  # Start in insert mode

    # Shell initialization following Home Manager patterns
    # Uses initContent (like starship module) instead of deprecated initExtra
    initContent = lib.concatStringsSep "\n" [
      # Vim mode - ESC key switches to normal mode (default behavior)
      "# Vim mode enabled via defaultKeymap"
      ""
      # Starship initialization (handled by programs.starship.enableZshIntegration)
      # Transient prompt setup after Starship is initialized
      (optionalString enableStarshipTransience starshipTransientPrompt)
      ""
      # Run fastfetch on interactive shells
      "if [[ \$- == *i* ]]; then"
      "  fastfetch"
      "fi"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      palette = "normal";

      format = "[╭╴](fg:arrow)$username$os$git_branch$directory$fill$cmd_duration $time( via $python$conda$nodejs$c$rust$java)\n[╰─](fg:arrow)$character";

      palettes = {
        normal = {
          arrow = "#B3BCFD";
          os = "#B3BCFD";
          os_admin = "#B3BCFD";
          directory = "#B3BCFD";
          time = "#B3BCFD";
          node = "#a5e6ba";
          git = "#f17f29";
          git_status = "#DFEBED";
          python = "#edf67d";
          conda = "#70e000";
          java = "#F86279";
          rust = "#ffdac6";
          clang = "#caf0f8";
          duration = "#ce4257";
          text_color = "#EDF2F4";
          text_light = "#26272A";
        };
      };

      username = {
        style_user = "bold os";
        style_root = "bold os_admin";
        format = "[$user](fg:$style) ";
        disabled = false;
        show_always = true;
      };

      os = {
        format = "on [($name)]($style) ";
        style = "bold blue";
        disabled = true;
        symbols = {
          Alpine = " ";
          Arch = " ";
          Debian = " ";
          EndeavourOS = " ";
          Fedora = " ";
          Linux = " ";
          Macos = " ";
          Manjaro = " ";
          Mint = " ";
          NixOS = " ";
          openSUSE = " ";
          Pop = " ";
          SUSE = " ";
          Ubuntu = " ";
          Windows = " ";
        };
      };

      character = {
        success_symbol = "[󰍟](fg:arrow)";
        error_symbol = "[󰍟](fg:red)";
      };

      directory = {
        format = "at [$path](bold $style)[$read_only]($read_only_style) ";
        truncation_length = 2;
        style = "fg:directory";
        read_only_style = "fg:directory";
        before_repo_root_style = "fg:directory";
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = "  ";
      };

      time = {
        disabled = false;
        format = "[$time]($style) ";
        time_format = "%H:%M";
        style = "bold fg:time";
      };

      cmd_duration = {
        disabled = false;
        format = "took [$duration]($style) ";
        style = "bold fg:duration";
        min_time = 500;
      };

      git_branch = {
        format = "via [$symbol$branch]($style) ";
        style = "bold fg:git";
        symbol = " ";
      };

      git_status = {
        format = "[$all_status$ahead_behind ]($style)";
        style = "fg:text_color bg:git";
        disabled = true;
      };

      docker_context = {
        disabled = false;
        symbol = " ";
      };

      package = {
        disabled = false;
      };

      fill = {
        symbol = "";
      };

      nodejs = {
        format = "[$symbol$version ]($style)";
        style = "bg:node fg:text_light";
        symbol = " ";
        version_format = "$raw";
        disabled = false;
      };

      python = {
        disabled = false;
        format = "[$symbol$pyenv_prefix($version)( \\($virtualenv\\)) ]($style)";
        symbol = " ";
        version_format = "$raw";
        style = "bg:python fg:text_light";
      };

      conda = {
        format = "[$symbol$environment ]($style)";
        style = "bg:conda fg:text_light";
        ignore_base = false;
        disabled = false;
        symbol = " ";
      };

      java = {
        format = "[$symbol$version ]($style)";
        style = "bg:java fg:text_light";
        version_format = "$raw";
        symbol = " ";
        disabled = false;
      };

      c = {
        format = "[$symbol($version(-$name)) ]($style)";
        style = "bg:clang fg:text_light";
        symbol = " ";
        version_format = "$raw";
        disabled = false;
      };

      rust = {
        format = "[$symbol$version ]($style)";
        style = "bg:rust fg:text_light";
        symbol = "󱘗 ";
        version_format = "$raw";
        disabled = false;
      };
    };
  };

}
