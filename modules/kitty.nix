# modules/kitty.nix
{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # 字体配置
    font = {
      name = "FiraCode Nerd Font"; # 建议确认系统中已安装此字体
      size = 12;
    };
    
    # 核心设置
    settings = {
      # 颜色主题 (可选，也可以用 shell_integration)
      background_opacity = "0.9"; # 稍微透明一点，更有科技感
      confirm_os_window_close = 0; # 关闭窗口时不弹出确认确认框
      
      # 性能优化
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # 记得配合你的 zsh
      shell = "zsh"; 
    };

    # 快捷键绑定 (完全可以根据你的习惯自定义)
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
