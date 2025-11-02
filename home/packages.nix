{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      lazygit        # Terminal UI for git
      htop
      tree
      ripgrep
      gh
      posting       # Terminal API client

      # programming languages
      nodejs_20       # Includes npm
      python3        # For uv
      uv              # Fast Python package installer
      gcc             # Includes g++

      # misc
      yt-dlp
      ffmpeg

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
