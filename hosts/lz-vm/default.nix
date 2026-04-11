{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./disk-config.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_net"
    "virtio_balloon"
    "virtio_ring"
  ];

  fileSystems."/persistent".neededForBoot = true;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=2G"
      "mode=755"
    ];
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
