# modules/git.nix
{ config, pkgs, ... }:
{
  # === Git 配置 (新版写法，消灭警告) ===
  programs.git = {
    enable = true;
    
    # 以前散落在外面的 userName, userEmail, extraConfig
    # 现在全部统一放到 settings 里面，层级更清晰
    settings = {
      # 用户信息
      user = {
        name = "Jaanai-Liu";
        email = "liujaanai@gmail.com";
      };

      # 初始化设置
      init = {
        defaultBranch = "main";
      };

      # 核心设置
      core = {
        fileMode = false;
        # editor = "vim";  # 你甚至可以在这设置默认编辑器
      };

      aliases = {
        ci = "commit";
        co = "checkout";
        st = "status";
      };

      # 代理设置 (如果有)
      # http = { proxy = "http://127.0.0.1:7897"; };
      # https = { proxy = "http://127.0.0.1:7897"; };
    };
  };
}
