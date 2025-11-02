{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      neovim
      htop
      tree
      ripgrep
      gh
      zoxide

      # programming languages

      # misc
      yt-dlp
      ffmpeg

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
