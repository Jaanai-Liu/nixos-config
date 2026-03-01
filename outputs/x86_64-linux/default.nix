# outputs/x86_64-linux/default.nix
{ inputs, mylib, nixpkgs, home-manager, ... }:

let
  system = "x86_64-linux";

  # 核心魔法：这是一个“造机模具”函数
  mkHost = hostName: nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs mylib; };

    modules = [
      # 动态拼接路径，自动去hosts目录下找对应主机的配置
      ../../hosts/${hostName}/configuration.nix
      
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs mylib; };
        
        # 动态引入对应主机的home配置
        home-manager.users.zheng = import ../../hosts/${hostName}/home.nix;
      }
    ];
  };
in
{
  # 见证奇迹的时刻：只需要调用模具，就能独立生成两台电脑的配置！
  # "LiuZheng" = mkHost "LiuZheng";
  "lz-pc" = mkHost "lz-pc";
  "lz-laptop" = mkHost "lz-laptop";
  
  # 如果以后有第三台电脑，直接加一行 "新主机名" = mkHost "新主机名"; 即可
}
