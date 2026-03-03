{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
  ];

  programs.niri.settings = {
    # spawn-at-startup 是 niri 的“开机启动清单”
    spawn-at-startup = [
      # 启动 swww 的后台服务
      { command = [ "${pkgs.swww}/bin/swww-daemon" ]; }
      # 设置壁纸
      { 
        command = [ 
          "${pkgs.swww}/bin/swww" "img" 
          "/etc/wallpapers/blood_marry.jpg" 
          "--transition-type" "wipe"  # 加入一个酷炫的擦除过渡效果
        ]; 
      }
    ];
  };
}