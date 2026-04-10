# modules/desktop/user-group.nix
{
  myvars,
  config,
  pkgs,
  ...
}:
{
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  # programs.zsh.enable = true;

  users.users.${myvars.username} = {
    description = myvars.userfullname;
    inherit (myvars) initialHashedPassword;
    home = "/home/${myvars.username}";
    isNormalUser = true;
    extraGroups = [
      myvars.username
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "dialout"
      "tty"
      "docker"
      "render"
    ];
    # shell = pkgs.zsh;
    openssh.authorizedKeys.keys = myvars.sshAuthorizedKeys;
  };

  users.users.root = {
    inherit (myvars) initialHashedPassword;
    openssh.authorizedKeys.keys = config.users.users."${myvars.username}".openssh.authorizedKeys.keys;
  };
}
