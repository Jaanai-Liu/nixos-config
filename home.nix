
{ config, pkgs, ... }:

{
  imports = [
    #./home/git.nix
    #./home/vim.nix
    #./home/zsh.nix    
    #./home/vlc.nix
    #./home/alist.nix
    #./home/niri.nix
    #./home/kitty.nix
    #./home/nnn.nix
    #./home/yazi.nix
    #./home/dev-tools.nix
    ./home

    # ./modules/networking
  ];
  # 注意修改这里的用户名与用户目录
  home.username = "zheng";
  home.homeDirectory = "/home/zheng";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[
    fastfetch
    tmux
    nodejs
    #htop
    btop

    micromamba

    localsend

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
    # vscode
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
