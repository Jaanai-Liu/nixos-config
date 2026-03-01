# modules/nnn.nix
{ config, pkgs, ... }:
{
  programs.nnn = {
    enable = true;
  };
}
