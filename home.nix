
{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "zheng";
  home.homeDirectory = "/home/zheng";
  # 也可以在这里ln文件到用户目录，或者直接text写文件到用户目录
  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装 这里就安装了一个 neofetch
  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[
    fastfetch
    tmux
    nodejs
    htop

    anydesk

    # media
    gimp
    darktable
    kdePackages.kdenlive

    # video
    vlc
    obs-studio

    clash-verge-rev

    alist

    # thefuck
    # gnome-extensions-app
    gnome-extension-manager
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    # gnomeExtensions.kimpanel
    gnomeExtensions.clipboard-indicator

    wechat
    wpsoffice-cn
    vscode
    obsidian

  ];


  # 2. Zsh 配置 (替代 .zshrc)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;      # 对应 zsh-autosuggestions
    syntaxHighlighting.enable = true;  # 对应 zsh-syntax-highlighting

    # 对应 Oh My Zsh 配置 [cite: 3]
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";          # 对应 ZSH_THEME [cite: 3]
      plugins = [ "git" "z" ]; # 对应 plugins=(...) 
    };

    # 对应 alias 配置 [cite: 21]
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      f = "fastfetch";
      g = "gvim";
      c = "code";
      b = "cd ..";
      ge = "gedit";
      py = "python3";
      # 注意：conda activate 最好在 initExtra 中处理，或直接在 shell 中使用
      mlp = "conda activate mlp";
      fixchrome = "pkill -f chrome; rm -rf ~/.config/google-chrome/Singleton*";
    };

    # 这里放入所有原本 zshrc 中无法标准化的脚本 (Conda, 函数, export 等)
    initContent = ''
      # 强制设置环境变量
      export IM_MODULE=fcitx
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS="@im=fcitx"
      
      # 自定义函数
      function cd() {
          builtin cd "$@" && ls
      }

      # >>> conda initialize >>> (保留你原本的 Conda 配置) [cite: 26]
      __conda_setup="$('/home/zheng/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/home/zheng/miniforge3/etc/profile.d/conda.sh" ]; then
              . "/home/zheng/miniforge3/etc/profile.d/conda.sh"
          else
              export PATH="/home/zheng/miniforge3/bin:$PATH"
          fi
      fi
      unset __conda_setup
      # <<< conda initialize <<<
      
      # Mamba 初始化 [cite: 29]
      export MAMBA_EXE='/home/zheng/miniforge3/bin/mamba';
      export MAMBA_ROOT_PREFIX='/home/zheng/miniforge3';
      __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__mamba_setup"
      else
          alias mamba="$MAMBA_EXE"
      fi
      unset __mamba_setup
    '';
  };

  # 3. Vim 配置 (替代 .vimrc)
  programs.vim = {
    enable = true;
    # package = pkgs.vim-full; 
    defaultEditor = true; # 会自动设置 EDITOR=vim
    # 使用 Nix 管理插件，替代 vim-plug 
    plugins = with pkgs.vimPlugins; [
      nerdtree                 # Preservim/nerdtree
      gruvbox                  # morhetz/gruvbox
      vim-airline              # vim-airline
      vim-airline-themes
      coc-nvim                 # neoclide/coc.nvim 
      verilog_systemverilog-vim # vhda/verilog_systemverilog.vim (需要确认pkgs里具体名字，通常是这个)
    ];

    # 将 vimrc 中的设置直接贴在这里
    extraConfig = ''
      set clipboard=unnamedplus
      set nocompatible
      filetype plugin indent on
      syntax on
      set encoding=utf-8
      set number
      set cursorline
      set ruler
      set nowrap
      
      " 字体设置 (从你的 vimrc 复制)
      if has("gui_running")
        set guifont=DejaVu\ Sans\ Mono\ 11
        set guifontwide=Noto\ Sans\ CJK\ SC\ 11
      endif

      " 缩进
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set autoindent

      " 配色
      try
          colorscheme gruvbox
          set background=dark
      catch
          colorscheme desert
      endtry

      " NERDTree 快捷键 [cite: 33]
      nnoremap <F2> :NERDTreeToggle<CR>
      autocmd VimEnter * NERDTree | if argc() > 0 | wincmd p | endif
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

      " COC 补全设置 [cite: 35]
      inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                             \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction
    '';
  };


  # 定义alist后台服务
  systemd.user.services.alist = {
    Unit = {
      Description = "Alist file server";
      After = [ "network.target" ];
    };
    
    Service = {
      Type = "simple";
      # 指定启动命令
      ExecStart = "${pkgs.alist}/bin/alist server";
      # 设置工作目录 (数据会存在 ~/.local/share/alist 或者该目录下)
      WorkingDirectory = "%h"; 
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # === Git 配置 (新版写法，消灭警告) ===
  programs.git = {
    enable = true;
    
    # 以前散落在外面的 userName, userEmail, extraConfig
    # 现在全部统一放到 settings 里面，层级更清晰
    settings = {
      # 用户信息
      user = {
        name = "LiuZheng";
        email = "你的邮箱@example.com";
      };

      # 初始化设置
      init = {
        defaultBranch = "main";
      };

      # 核心设置
      core = {
        fileMode = false;
        # editor = "vim";  # 你甚至可以在这设置默认编辑器
      };

      # 代理设置 (如果有)
      # http = { proxy = "http://127.0.0.1:7897"; };
      # https = { proxy = "http://127.0.0.1:7897"; };
    };
  };

  #programs.clash-verge = {
  #  enable = true;                  # 启用模块，会自动安装并配置桌面集成
  #  package = pkgs.clash-verge-rev; # 指定使用 clash-verge-rev（默认也是这个）
  #  tunMode = true;                 # 关键：为程序设置 setcap 权限，允许启用 TUN 模式
  #};
  
  home.stateVersion = "25.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
