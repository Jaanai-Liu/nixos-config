
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
  # 也可以在这里ln文件到用户目录，或者直接text写文件到用户目录
  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装 这里就安装了一个 neofetch
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

  ];

  home.stateVersion = "25.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
