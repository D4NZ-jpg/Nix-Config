{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      lazygit # Terminal UI for git
      lf # Terminal file manager
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

  # Spicetify configuration for Spotify customization
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.hazy;
    #theme = spicePkgs.themes.catppuccin;
    colorScheme = "Base";
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      keyboardShortcut
      loopyLoop
      trashbin
      autoVolume
      showQueueDuration
      history
      autoSkip
      playNext
      beautifulLyrics
      catJamSynced
    ];
  };
}
