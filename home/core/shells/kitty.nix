{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
  ];
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    keybindings = {
      "ctrl+shift+m" = "toggle_maximized";
      "ctrl+shift+f" = "show_scrollback";
    };

    settings = {
      hide_window_decorations = "yes";
      
      background_opacity = "0.93";
      background_blur = 1; # 加上一点高斯模糊会更有高级感
      
      enable_audio_bell = false;
      tab_bar_edge = "top";
      
      # 通过 Bash 启动你熟悉的 Zsh 环境，解决环境变量加载问题
      shell = "${pkgs.bash}/bin/bash --login -c '${pkgs.zsh}/bin/zsh --login --interactive'";
    };
  };
}