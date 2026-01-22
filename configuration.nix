# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  # nix.settings.proxy = "http://127.0.0.1:7897"; # 换成你的代理端口
  networking.proxy.default = "http://127.0.0.1:7897";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #nixpkgs.config.allowUnfree = true;
  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "LiuZheng"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Hibernate 休眠
  boot.resumeDevice = "/dev/disk/by-uuid/8b14124f-e4c1-4f9d-9e9d-af852e1bc152";
  # 电源管理
  powerManagement.enable = true;

  programs.niri.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  
  # Flatpak
  services.flatpak.enable = true;  # 启用 Flatpak
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zheng = {
    isNormalUser = true;
    description = "LiuZheng";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  environment.gnome.excludePackages = [ pkgs.epiphany ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    wget
    # clash-verge-rev
    # git
    fastfetch
    htop
    vim-full
    pkgs.fcitx5-material-color
    gnomeExtensions.hibernate-status-button
  ];


  # fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans       # 谷歌 Noto 黑体 (最重要，覆盖简繁日韩)
      noto-fonts-cjk-serif      # 谷歌 Noto 宋体
      wqy_zenhei                # 文泉驿正黑 (老牌好用的开源字体)
      wqy_microhei              # 文泉驿微米黑
      # sarasa-gothic           # 更纱黑体 (代码编程很好看，可选)
      # source-han-sans         # 思源黑体 (如果 Noto 不够用可以加上这个)
    ];

    #以此配置默认字体，确保浏览器优先使用中文字体
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK SC" "Noto Sans Mono" ];
      };
    };
  };


  #security.wrappers.clash-verge = {
  #  owner = "root";
  #  group = "root";
  #  capabilities = "cap_net_bind_service,cap_net_admin=+ep";
  #  source = "${pkgs.clash-verge-rev}/bin/clash-verge";
  #};
  # networking.firewall.checkReversePath = "loose";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  programs.gamemode.enable = true;  # 启用 GameMode
  
  #environment.sessionVariables = {
  #  STEAM_FORCE_DESKTOPUI_SCALING = "1.5";  # 可选：调整 UI 缩放
  #};

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # 确保安装了这两个 addon，这对修复位置偏移很重要
      addons = with pkgs; [
        fcitx5-rime
        fcitx5-gtk   # 修复 GTK 程序(如 Firefox, Chrome) 的位置
        # fcitx5-qt  # 如果你有 QT 程序的问题，把这个注释打开
      ];
      
      # 如果你是 GNOME 或 KDE 等 Wayland 环境，加上这行：
      waylandFrontend = true; 
    };
  };

  # 强制设置环境变量，修复“候选框不跟随”的顽疾
  environment.sessionVariables = {
    # 告诉系统尽量使用 Fcitx5 进行输入
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "alist-3.45.0"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
