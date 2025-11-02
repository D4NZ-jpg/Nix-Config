{
  pkgs,
  dotfilesPath ? null,
  ...
}:
let
  # ========================================
  # Dotfiles Configuration
  # ========================================
  #
  # Dotfiles path passed from flake inputs
  # Falls back to local path if not provided
  #
  dotfiles = if dotfilesPath != null then dotfilesPath else "/Users/dan/dotfiles";
in
{
  # ========================================
  # Tool Configurations using Home Manager
  # ========================================

  # Bat - cat with syntax highlighting
  programs.bat = {
    enable = true;
  };

  # Zoxide - smarter cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Neovim - use your existing config from dotfiles
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # Kitty - basic terminal configuration in Nix
  programs.kitty = {
    enable = true;
    settings = {
      # Basic Kitty settings
      font_family = "FiraCode Nerd Font";
      font_size = 12;
      background_opacity = "0.95";
      cursor_shape = "beam";
      enable_audio_bell = false;
      window_padding_width = 10;
    };
  };

  # Fastfetch - basic Darwin configuration in Nix
  programs.fastfetch = {
    enable = true;
    # Basic settings for macOS
    settings = {
      logo = {
        source = "auto";
      };
      display = {
        separator = "─";
      };
    };
  };

  # ========================================
  # Link Neovim Config from Dotfiles
  # ========================================
  #
  # Only Neovim config is linked from dotfiles (as requested)
  # Everything else is configured in Nix above

  # Neovim - link your full config from dotfiles
  home.file.".config/nvim".source = "${dotfiles}/dot_config/nvim";
}
