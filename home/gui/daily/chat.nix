{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qq
    wechat-uos
    feishu
    # telegram-desktop
    discord
  ];

  # home.sessionVariables = {
  #   NIXOS_OZONE_WL = "1";
  # };

  # xdg.desktopEntries."wechat-uos" = {
  #   name = "WeChat";
  #   # 核心修改：使用Nix多行字符串语法，内部直接使用双引号
  #   exec = ''bash -lc "wechat-uos %U"'';
  #   terminal = false;
  #   icon = "wechat";
  #   type = "Application";
  #   categories = [ "Network" "InstantMessaging" ];
  # };
}
