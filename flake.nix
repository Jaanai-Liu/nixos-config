{
  description = "lz's flake! PS: A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";


    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";  # 使用相同的 nixpkgs
    };

    # niri.url = "github:YaLTeR/niri";
  };


  outputs = { self, nixpkgs, home-manager, ... }: {

    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations = {
      LiuZheng = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # 把 inputs 传给所有模块，这样我们在 configuration.nix 里也能用
        # specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          
          # 将 home-manager 配置为 nixos 的一个 module
          # 这样在 nixos-rebuild switch 时，home-manager 配置也会被自动部署
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 这里的 import 函数在前面 Nix 语法中介绍过了，不再赘述
            home-manager.users.zheng = import ./home.nix;

            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            # home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
