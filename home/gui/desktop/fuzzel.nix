{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
  ];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # 核心设置：使用你的Kitty终端
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        # 使用你偏好的JetBrainsMono字体
        font = "JetBrainsMono Nerd Font:size=14";
        prompt = "󰍉 ";
        icon-theme = "Papirus-Dark";
        width = 25;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
        line-height = 25;
        letter-spacing = 0.5;
        # 限制显示数量，保持界面简洁
        fields = "filename,name,generic";
      };

      colors = {
        # 这里的配色与你之前的配置保持一致（带透明度的Dracula风）
        background = "282a36b3";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection = "44475aff";
        selection-text = "8be9fdff";
        selection-match = "8be9fdff";
        border = "bd93f9ff";
      };

      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}