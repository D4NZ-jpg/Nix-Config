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
      "cursor-cli"
      "kitty"
      "postman"

      # messaging
      "discord"
      "slack"
      "whatsapp"

      # other
      "anki"
      "obsidian"
      "zen"
    ];
    brews = [
    ];
    taps = [
      "nikitabobko/tap"
    ];
  };
}
