{ primaryUser, inputs, ... }:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./dotfiles.nix
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
      EDITOR = "nvim";
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };

  # Launch Raycast on login using launchd
  launchd.agents.raycast = {
    enable = true;
    config = {
      Label = "com.raycast.macos";
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "Raycast"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };

  # TopNotch is launched via macOS Login Items (see darwin/settings.nix)
  # This is better for menu bar apps than launchd agents
}
