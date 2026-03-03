{ pkgs, ... }:
{
  # 1. 安装 Fuzzel
  home.packages = with pkgs; [
    fuzzel
  ];

  # 2. 配置 Fuzzel 的外观（可选，让它匹配你的 Waybar 暗色主题）
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot"; # 默认终端
        layer = "overlay";
        font = "JetBrainsMono Nerd Font:size=14";
        prompt = "󰍉 "; # 搜索图标
      };
      colors = {
        background = "282a36fa"; # 深色半透明
        text = "f8f8f2ff";
        match = "8be9fdff"; # 匹配字符的颜色
        selection = "44475aff";
        selection-text = "8be9fdff";
        border = "bd93f9ff";
      };
    };
  };

  # 3. 绑定快捷键到 Niri
  programs.niri.settings.binds = {
    # 习惯上使用 Mod + D 或 Mod + R 来启动应用搜索
    "Alt+Space".action.spawn = [ "fuzzel" ];
    # "Mod+D".action.spawn = [ "fuzzel" ];
  };
}