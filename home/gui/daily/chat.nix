{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qq
    # nur-xddxdd.wechat-uos-sandboxed
    wechat-uos
    feishu
    telegram-desktop
    discord
  ];
}
