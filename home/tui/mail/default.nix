{
  config,
  lib,
  pkgs,
  ...
}@args:

let
  cfg = config.home.tui.mail;
  mail-scripts = pkgs.mkScriptsPackage "mail-scripts" ./scripts;
in
{
  options.home.tui.mail = {
    enable = lib.mkEnableOption "TUI Mail setup";
  };

  # imports = [
  #   ./aerc
  #   ./offlineimap
  #   ./imapnotify
  # ];

  # config = lib.mkIf cfg.enable {
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home.packages = with pkgs; [
          mail-scripts
          libnotify
          pulseaudio
        ];
      }
      (import ./aerc args)
      (import ./offlineimap args)
      (import ./imapnotify args)
    ]
  );
}
