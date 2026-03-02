{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans       #谷歌Noto黑体
      noto-fonts-cjk-serif      #谷歌Noto宋体
      wqy_zenhei                #文泉驿正黑
      wqy_microhei              #文泉驿微米黑
    ];

    #配置默认字体，确保浏览器优先使用中文字体
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK SC" "Noto Sans Mono" ];
      };
    };
  };
}