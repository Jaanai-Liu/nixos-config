<h2 align="center">:snowflake: LiuZheng's NixOS Config :snowflake:</h2>

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="400" />
</p>

<p align="center">
  <a href="https://github.com/Jaanai-Liu/nixos-config/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/Jaanai-Liu/nixos-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-25.11-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
</p>

> This repository contains my personal NixOS configurations (featuring Niri, home-manager, and Agenix). **I built and modularized the entire structure myself, with huge inspiration and reference from [Ryan's NixOS & Flakes Book](https://github.com/ryan4yin/nixos-and-flakes-book) and his [personal dotfiles](https://github.com/ryan4yin/nix-config).** Please note that as the config grows, **it will be quite complex for beginners to read.**

## 💻 Hardware Overview

* **Host (`lz-pc`)**: PC(Intel Core: i5-12400F AMD Radeon GPU: 9060XT)

## 🧩 Components

| Category | Software / Configuration |
| :--- | :--- |
| **Window Manager** | [Niri](https://github.com/YaLTeR/niri) (Wayland) |
| **Status Bar & Shell** | [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) |
| **Terminal Emulator** | [Kitty](https://github.com/kovidgoyal/kitty) |
| **Text Editor & IDE** | [Neovim](https://github.com/neovim/neovim) + [VSCode](https://code.visualstudio.com/) ([NerdFonts](https://github.com/ryanoasis/nerd-fonts)) |
| **Idle & Power Management** | [hypridle](https://github.com/hyprwm/hypridle) (5min/10min/15min stepped suspend) |
| **Lock Screen** | [swaylock-effects](https://github.com/mortie/swaylock-effects) (Blur & Fade-in) |
| **Display Manager** | [tuigreet](https://github.com/apognu/tuigreet) |
| **Shell Environment** | [zsh](https://www.zsh.org/) + [Starship](https://starship.rs/) |
| **Input Method** | [Fcitx5](https://github.com/fcitx/fcitx5) + [rime](https://rime.im/) |
| **System Monitor** | [Btop](https://github.com/aristocratos/btop) |
| **File Manager** | [Yazi](https://github.com/sxyazi/yazi) |
| **Note-Taking** | [Obsidian](https://obsidian.md/) |
| **Cloud Storage Mount** | [Alist](https://github.com/alist-org/alist) (Locked via Flake) |

🎨 **Wallpapers**: [My Wallpapers Collection](https://github.com/Jaanai-Liu/nixos-config/tree/main/wallpapers)

## 🔒 Secrets Management

See [./secrets](https://www.google.com/search?q=./secrets) for details (Managed by Agenix).

## 🚀 How to Deploy this Flake?

> :red_circle: **IMPORTANT**: **You should NOT deploy this flake directly on your machine :exclamation: It will not succeed.** > This flake contains specific hardware configurations (such as CPU microcode for Intel i5-12400F, AMD Radeon GPU 9060XT, and specific disk mount points) along with encrypted secrets via Agenix. You may use this repo as a reference to build your own configuration.

```bash
# Deploy the configuration based on the hostname (lz-pc)
sudo nixos-rebuild switch --flake .#lz-pc

```

> ⚠️**注意**：部署前需要修改hosts路径下的niri文件配置output.kdl！
