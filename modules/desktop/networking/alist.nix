# modules/alist.nix
{
  config,
  pkgs,
  myvars,
  ...
}:

let
  runUser = myvars.username;
in
{
  environment.systemPackages = [ pkgs.alist ];

  systemd.services.alist = {
    description = "Alist File Server Daemon";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = runUser;

      StateDirectory = "alist";

      ExecStart = "${pkgs.alist}/bin/alist server --data /var/lib/alist";

      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
