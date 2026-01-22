# modules/zsh.nix
{ config, pkgs, ... }:
{
  # Zsh 配置 (替代 .zshrc)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;      # 对应 zsh-autosuggestions
    syntaxHighlighting.enable = true;  # 对应 zsh-syntax-highlighting

    # 对应 Oh My Zsh 配置 [cite: 3]
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";          # 对应 ZSH_THEME [cite: 3]
      plugins = [ "git" "z" ]; # 对应 plugins=(...) 
    };

    # 对应 alias 配置 [cite: 21]
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      f = "fastfetch";
      g = "gvim";
      c = "code";
      b = "cd ..";
      ge = "gedit";
      py = "python3";
      # 注意：conda activate 最好在 initExtra 中处理，或直接在 shell 中使用
      mlp = "conda activate mlp";
      fixchrome = "pkill -f chrome; rm -rf ~/.config/google-chrome/Singleton*";
    };

    # 这里放入所有原本 zshrc 中无法标准化的脚本 (Conda, 函数, export 等)
    initContent = ''
      # 强制设置环境变量
      export IM_MODULE=fcitx
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS="@im=fcitx"
      
      # 自定义函数
      function cd() {
          builtin cd "$@" && ls
      }
      
      # Micromamba 初始化
      export MAMBA_ROOT_PREFIX=$HOME/micromamba
      eval "$(micromamba shell hook --shell zsh)"
      alias conda="micromamba"

      # auto-act & change color
      micromamba activate base
    '';
  };
}
