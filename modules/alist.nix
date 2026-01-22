# modules/alist.nix
{ config, pkgs, ... }:
{
  # 定义alist后台服务
  systemd.user.services.alist = {
    Unit = {
      Description = "Alist file server";
      After = [ "network.target" ];
    };
    
    Service = {
      Type = "simple";
      # 指定启动命令
      ExecStart = "${pkgs.alist}/bin/alist server";
      # 设置工作目录 (数据会存在 ~/.local/share/alist 或者该目录下)
      WorkingDirectory = "%h"; 
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
