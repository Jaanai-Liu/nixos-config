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
    # we have to use initialHashedPassword here when using tmpfs for /
    inherit (myvars) initialHashedPassword;
    home = "/home/${myvars.username}";
    isNormalUser = true;
    extraGroups = [
      myvars.username
      "wheel"
      "networkmanager" # for nmtui / nm-connection-editor
      "video"
      "audio"
      "dialout"
      "tty"
      "docker"
      # "render"
    ];
    # shell = pkgs.zsh;
    openssh.authorizedKeys.keys = myvars.sshAuthorizedKeys;
  };

  # root's ssh key are mainly used for remote deployment
  users.users.root = {
    inherit (myvars) initialHashedPassword;
    openssh.authorizedKeys.keys = config.users.users."${myvars.username}".openssh.authorizedKeys.keys;
  };
}
