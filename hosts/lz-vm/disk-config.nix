{
  # 1. 魔法：真正的“阅后即焚”根目录
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=2G"
      "mode=755"
    ];
  };

  # 2. 真实的物理硬盘分区图纸
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda"; # KVM 虚拟机的标准硬盘名
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            persistent = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  # 我们只建两个子卷：系统运行库和你的私人宝库
                  "/nix" = {
                    mountpoint = "/nix";
                  };
                  "/persistent" = {
                    mountpoint = "/persistent";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
