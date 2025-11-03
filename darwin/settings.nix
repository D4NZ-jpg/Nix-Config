{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # system defaults and preferences
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    startup.chime = false;

    defaults = {
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      finder = {
        AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = true; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };

      # Dock configuration
      dock = {
        # Icon size (16-128, default is 64)
        tilesize = 16;
        
        # Dock position: "left", "bottom", or "right"
        orientation = "left";
        
        # Auto-hide Dock
        autohide = true;
        
        # Show hidden apps in Dock (transparent icons)
        showhidden = false;
        
        # Minimize effect: "genie", "scale", or "suck"
        mineffect = "genie";
        
        # Magnification (set to false to disable)
        magnification = false;
        
        # Magnified icon size (16-128)
        largesize = 16;
        
        # Show only running applications
        static-only = true;
        
        # Show running process indicators
        show-process-indicators = true;
        
        # Show recent applications
        show-recents = false;
        
        # Enable spring loading (drag files over apps to open)
        enable-spring-load-actions-on-all-items = false;
        
        # Scroll to open folders (set to false to disable)
        scroll-to-open = true;
        
        # Apps to always show in Dock (set persistent apps)
        # persistent-apps = [
        #   "/Applications/Safari.app"
        #   "/Applications/Mail.app"
        # ];
        
        # Folders to show in Dock
        # persistent-others = [
        #   "$HOME/Downloads"
        # ];
      };

      # Keyboard shortcuts configuration
      # Using CustomUserPreferences for complex plist structures
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "64" = {
              # Disable Spotlight Cmd+Space (key 64)
              # This will uncheck "Show Spotlight search" in System Settings
              enabled = false;
              value = {
                parameters = [ 65535 49 1048576 ];
                type = "standard";
              };
            };
          };
        };
      };
    };
  };

  # Add Raycast to login items so it starts on login
  # Based on: https://discourse.nixos.org/t/automatically-launching-macos-applications-on-login/19823
  # Running this every time is safe - it won't create duplicate entries
  system.activationScripts.configureRaycastLoginItem = ''
    echo "Configuring Raycast to start on login..."
    
    if [ -d "/Applications/Raycast.app" ]; then
      osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Raycast.app", hidden:false}' || true
      echo "Raycast configured to start on login."
    else
      echo "Raycast not found. It will be added to login items once installed."
    fi
  '';
}
