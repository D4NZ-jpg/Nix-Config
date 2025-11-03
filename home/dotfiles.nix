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

  # Kitty - Everforest Dark Hard theme
  programs.kitty = {
    enable = true;
    settings = {
      # Font settings
      font_family = "FiraCode Nerd Font";
      font_size = 12;
      background_opacity = 0.8;
      cursor_shape = "beam";
      enable_audio_bell = false;
      window_padding_width = 10;

      # Everforest Dark Hard theme colors
      foreground = "#d3c6aa";
      background = "#2b3339";
      selection_foreground = "#9da9a0";
      selection_background = "#503946";

      cursor = "#d3c6aa";
      cursor_text_color = "#323c41";

      url_color = "#7fbbb3";

      active_border_color = "#a7c080";
      inactive_border_color = "#53605c";
      bell_border_color = "#e69875";
      visual_bell_color = "none";

      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      active_tab_background = "#2b3339";
      active_tab_foreground = "#d3c6aa";
      inactive_tab_background = "#3a454a";
      inactive_tab_foreground = "#9da9a0";
      tab_bar_background = "#323c41";
      tab_bar_margin_color = "none";

      mark1_foreground = "#2b3339";
      mark1_background = "#7fbbb3";
      mark2_foreground = "#2b3339";
      mark2_background = "#d3c6aa";
      mark3_foreground = "#2b3339";
      mark3_background = "#d699b6";

      # Black
      color0 = "#374247";
      color8 = "#63767E";

      # Red
      color1 = "#e67e80";
      color9 = "#e67e80";

      # Green
      color2 = "#a7c080";
      color10 = "#a7c080";

      # Yellow
      color3 = "#dbbc7f";
      color11 = "#dbbc7f";

      # Blue
      color4 = "#7fbbb3";
      color12 = "#7fbbb3";

      # Magenta
      color5 = "#d699b6";
      color13 = "#d699b6";

      # Cyan
      color6 = "#83c092";
      color14 = "#83c092";

      # White
      color7 = "#859289";
      color15 = "#9da9a0";
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
