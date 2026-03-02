{
  pkgs,
  config,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fastfetch
    vim-full
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tmux # Terminal split tool
    wget
    git

    # system monitoring
    btop
    # htop
    
    

    # system tools
    psmisc # killall/pstree/prtstat/fuser/...
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
    parted

    pkgs.fcitx5-material-color
    gnomeExtensions.power-off-options
    
  ];


  # BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
  # https://github.com/iovisor/bcc
  # programs.bcc.enable = true;

  # replace default editor with neovim
  environment.variables.EDITOR = "vim-full";
}
