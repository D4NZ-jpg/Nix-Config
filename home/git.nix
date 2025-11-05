{ primaryUser, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Danz";
        email = "57308957+D4NZ-jpg@users.noreply.github.com";
      };
      github = {
        user = primaryUser;
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        autocrlf = "input";
        excludesfile = "~/.gitignore_global";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      diff = {
        colorMoved = "default";
      };
    };

    lfs.enable = true;

    ignores = [
      "**/.DS_STORE"
      "**/node_modules"
      "**/.venv"
      "**/__pycache__"
      "**/*.pyc"
      "**/.pytest_cache"
      "**/.mypy_cache"
      "**/.idea"
      "**/.vscode"
    ];
  };
}
