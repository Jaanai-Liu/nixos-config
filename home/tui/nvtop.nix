{
  pkgs,
  ...
}:
{
  programs.nvtopPackages = {
    amd = {
      enable = true;
    };
  };
}
