{ pkgs, ... }:
{
  # 1. 安装 Waybar 和图标字体
  home.packages = with pkgs; [
    waybar
    # 极力推荐：JetBrainsMono Nerd Font，自带几千个图标，是 Waybar 的标配
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts-cjk-sc # 确保状态栏中文不乱码
  ];

  # 2. 将 Waybar 加入 Niri 开机启动
  programs.niri.settings.spawn-at-startup = [
    { command = [ "${pkgs.waybar}/bin/waybar" ]; }
  ];

  # 3. Waybar 详细配置
  programs.waybar = {
    enable = true;
    # 配置文件 (config.jsonc)
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      modules-left = [ "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "network" "tray" ];

      "niri/window" = {
        format = "󰖲 {}"; # 使用了 Nerd Font 的图标
      };

      "clock" = {
        format = " {:%H:%M}";
        format-alt = "󰃭 {:%Y-%m-%d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "cpu" = {
        format = " {usage}%";
      };

      "memory" = {
        format = " {percentage}%";
      };

      "network" = {
        format-wifi = " {essid}";
        format-ethernet = "󰈀 eth";
        format-disconnected = "󰖪 off";
      };
    }];

    # 4. 样式表 (style.css) - 这里定义字体
    style = ''
      * {
        /* 优先级：Nerd Font 图标 -> 你的中文字体 */
        font-family: "JetBrainsMono Nerd Font", "WenQuanYi Zen Hei", sans-serif;
        font-size: 14px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: rgba(43, 48, 59, 0.5); /* 半透明深色 */
        color: #ffffff;
        border-bottom: 2px solid rgba(100, 114, 125, 0.5);
      }

      #clock, #cpu, #memory, #network, #window {
        padding: 0 10px;
        margin: 0 5px;
      }

      #clock {
        color: #64f1f1;
      }

      #cpu {
        color: #fb8c00;
      }
    '';
  };
}