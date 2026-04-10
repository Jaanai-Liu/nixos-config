_: {
  allowUnfree = true;

  # permittedInsecurePackages = [
  #   "alist-3.45.0"
  # ];

  nixpkgs.config.permittedInsecurePackages = [
    "alist-${pkgs.alist.version}"
    "ventoy-${pkgs.ventoy.version}"
  ];

  # nixpkgs.config.allowInsecurePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "ventoy"
  #   ];
}
