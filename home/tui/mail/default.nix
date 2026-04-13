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

  config = lib.mkIf cfg.enable {
    imports = [
      ./aerc
      ./offlineimap
      ./imapnotify
    ];

    home.packages = [
      (pkgs.mkScriptsPackage "mail-scripts" ./scripts)
    ];
  };
}
