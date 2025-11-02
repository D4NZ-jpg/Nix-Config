{ pkgs, ... }:
let
  # ========================================
  # Dotfiles Configuration
  # ========================================
  # 
  # To use your GitHub dotfiles, first clone them locally:
  #   git clone https://github.com/D4NZ-jpg/dotfiles.git ~/dotfiles
  #
  # Then uncomment and adjust the paths below to match your dotfiles structure.
  #
  dotfilesPath = "/Users/dan/dotfiles";  # Adjust if you clone elsewhere
  
in
{
  # ========================================
  # Tool Configurations using Home Manager
  # ========================================
  
  # Bat - cat with syntax highlighting
  programs.bat = {
    enable = true;
    # If you have bat config in dotfiles, uncomment:
    # configFile = "${dotfilesPath}/.config/bat/config";
  };
  
  # Zoxide - smarter cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    # Custom options if needed
    # options = [ "--cmd" "j" ];
  };
  
  # Fastfetch - system info
  programs.fastfetch = {
    enable = true;
    # If you have fastfetch config, uncomment:
    # configFile = "${dotfilesPath}/.config/fastfetch/config.json";
  };
  
  # Neovim - enable and optionally link your config
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    
    # Option A: Use your existing Neovim config from dotfiles
    # Uncomment this if your dotfiles have a nvim directory:
    # home.file.".config/nvim".source = "${dotfilesPath}/.config/nvim";
    
    # Option B: Use Home Manager's config (works alongside your files)
    # Uncomment to add extra config:
    # extraLuaConfig = ''
    #   -- Your additional Lua config here
    # '';
  };
  
  # ========================================
  # Link Other Dotfiles
  # ========================================
  # 
  # Uncomment the ones you want to use from your dotfiles repo:
  #
  
  # Shell configs (if not using Home Manager's programs.zsh)
  # home.file.".zshrc".source = "${dotfilesPath}/.zshrc";
  # home.file.".zprofile".source = "${dotfilesPath}/.zprofile";
  
  # Other config files
  # home.file.".tmux.conf".source = "${dotfilesPath}/.tmux.conf";
  # home.file.".config/alacritty/alacritty.yml".source = "${dotfilesPath}/.config/alacritty/alacritty.yml";
  
  # Git config (you're already using programs.git, but you can add extra files)
  # home.file.".config/git/ignore".source = "${dotfilesPath}/.config/git/ignore";
  
  # ========================================
  # Alternative: Fetch Directly from GitHub
  # ========================================
  # 
  # If you prefer to fetch directly (slower, less flexible):
  #
  # dotfiles = builtins.fetchGit {
  #   url = "https://github.com/D4NZ-jpg/dotfiles.git";
  #   ref = "main";  # Change to "master" if that's your default branch
  # };
  # 
  # Then use: home.file.".config/nvim".source = "${dotfiles}/.config/nvim";
}
