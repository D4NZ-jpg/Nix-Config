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
      "hiddenbar"
      "raycast"

      # dev
      "cursor"
      "kitty"
      "postman"

      # messaging
      "discord"
      "slack"

      # other
      "anki"
      "obsidian"
      "syncthing"
      "zen"
    ];
    brews = [
    ];
    taps = [
      "nikitabobko/tap"
    ];
  };
}
