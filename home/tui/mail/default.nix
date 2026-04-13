{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.home.tui.mail;
in
{
  options.home.tui.mail = {
    enable = lib.mkEnableOption "Enable mail client (aerc + offlineimap)";
  };

  imports = [
    ./aerc
    ./offlineimap
    ./imapnotify
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.mkScriptsPackage "mail-scripts" ./scripts)
    ];
  };
}
