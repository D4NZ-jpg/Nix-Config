{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      # OS enhancements
      #"aerospace"
      "cleanshot"
      "hiddenbar"
      "raycast"
      "betterdisplay"

      # dev
      "cursor"
      "kitty"

      # messaging
      "discord"
      "slack"

      # other
      "anki"
      "obsidian"
      "zen"
    ];
    brews = [
      "docker"
    ];
    taps = [
      "nikitabobko/tap"
    ];
  };
}
