# modules/niri.nix
{ config, pkgs, lib, ... }:

{
  # 1. 安装桌面相关软件
  home.packages = with pkgs; [
    niri
    fuzzel
    waybar
    mako
    swaybg
    swaylock
    grim
    slurp
    wl-clipboard
  ];

  # 2. Niri 核心配置
  # 这里依然使用 text block 方式，保持 KDL 原汁原味
  xdg.configFile."niri/config.kdl".text = ''
    // 这里粘贴你之前写好的全部 KDL 配置代码
    // ...
    binds {
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "fuzzel"; }
        // ...
    }
  '';

  # 3. (可选) 你甚至可以把 Waybar 的配置也写在这个文件里，实现“桌面全家桶”
  # programs.waybar = { ... };
}
