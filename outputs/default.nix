# outputs/default.nix
# inputs:
{ nixpkgs, home-manager, ... }@inputs:
let
  inherit (inputs) self nixpkgs home-manager;
  mylib = import ../lib { inherit (nixpkgs) lib; };
  
  # 把所有工具打包成一个通用参数包
  args = { inherit inputs mylib nixpkgs home-manager; };
in
{
  nixosConfigurations = import ./x86_64-linux args;
}
