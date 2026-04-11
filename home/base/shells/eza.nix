{
  # A modern replacement for ‘ls’
  # useful in bash/zsh prompt
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };
  programs.zsh.shellAliases = {
    # l = "eza -la";
    l = "eza";
  };
}
