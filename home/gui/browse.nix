{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    google-chrome
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
  };
}
