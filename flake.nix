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

  outputs = inputs: import ./outputs inputs;
}
