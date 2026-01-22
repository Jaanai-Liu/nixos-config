
{ config, pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/vim.nix
    ./modules/zsh.nix    
    ./modules/vlc.nix
    
    ./modules/alist.nix
    
    ./modules/niri.nix
    ./modules/kitty.nix
  ];
  # 注意修改这里的用户名与用户目录
  home.username = "zheng";
  home.homeDirectory = "/home/zheng";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[
    fastfetch
    tmux
    nodejs
    htop

    micromamba

    anydesk

    # media
    gimp
    darktable
    kdePackages.kdenlive

    # video
    # vlc
    obs-studio

    clash-verge-rev

    alist

    # thefuck

    # gnome Extension
    # gnome-extensions-app
    gnome-extension-manager
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    # gnomeExtensions.kimpanel
    gnomeExtensions.clipboard-indicator

    wechat
    wpsoffice-cn
    vscode
    obsidian


    # niri extension
    #(nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    font-awesome
  ];

  home.stateVersion = "25.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
