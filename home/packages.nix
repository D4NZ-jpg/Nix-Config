{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      lazygit # Terminal UI for git
      htop
      tree
      ripgrep
      gh
      posting # Terminal API client

      # programming languages
      nodejs_22 # Includes npm
      python3 # For uv
      uv # Fast Python package installer
      gcc # Includes g++
      luarocks
      lua5_1 # Lua 5.1 interpreter for Neovim



      # misc
      syncthing
      yt-dlp
      ffmpeg

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
