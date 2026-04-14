# hosts/lz-vps/home.nix
{ myvars, pkgs, ... }:

{
  imports = [
    ../../home/base
    ../../home/tui
  ];

  # home.desktop.niri.enable = true;
  # home.tui.mail.enable = true;

  home.username = myvars.username;
  home.homeDirectory = "/home/${myvars.username}";

  home.packages = with pkgs; [
    htop
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
