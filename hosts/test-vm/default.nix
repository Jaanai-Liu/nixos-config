{
  config,
  pkgs,
  lib,
  ...
}:

{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=2G"
      "mode=755"
    ];
  };

  fileSystems."/persistent" = {
    device = "/dev/vda";
    fsType = "ext4";
    autoFormat = true;
    neededForBoot = true;
  };

  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/log"
    ];
    users.zheng = {
      directories = [
        "Documents"
      ];
    };
  };

  users.users.zheng = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "1";
  };
  users.users.root.password = "1";

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  system.stateVersion = "25.11";
}
