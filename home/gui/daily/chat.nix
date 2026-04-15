{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qq
    wechat-uos
    feishu
    telegram-desktop
    discord
  ];

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    wqy_microhei
  ];
}
