{ primaryUser, ... }:
{
  programs.git = {
    enable = true;
    userName = "Danz";
    userEmail = "57308957+D4NZ-jpg@users.noreply.github.com";

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      github = {
        user = primaryUser;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
