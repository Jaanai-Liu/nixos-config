{
  lib,
  ...
}:
{
  allowUnfree = true;

  # nixpkgs.config.permittedInsecurePackages = [
  #   "ventoy-${pkgs.ventoy.version}"
  # ];

  allowInsecurePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "ventoy"
    ];
}
