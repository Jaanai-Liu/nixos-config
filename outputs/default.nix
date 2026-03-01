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
  # 将x86_64架构的装机任务，全部外包给x86_64-linux文件夹处理
  nixosConfigurations = import ./x86_64-linux args;
}
