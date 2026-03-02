# modules/alist.nix
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alist
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "alist-3.57.0"
  ];

  # 定义alist后台服务
  systemd.user.services.alist = {
    description = "Alist file server";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      # 指定启动命令
      ExecStart = "${pkgs.alist}/bin/alist server";
      # 设置工作目录 (数据会存在 ~/.local/share/alist 或者该目录下)
      WorkingDirectory = "%h"; 
      Restart = "on-failure";
    };
  };
}
