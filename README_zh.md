# ❄️ LiuZheng的NixOS配置

[![English](https://img.shields.io/badge/Language-English-blue.svg?style=flat-square)](README.md)

---

<p align="center">
<img src="[https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png](https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png)" width="400" />
</p>

> [!NOTE]
> 本仓库包含了我个人的模块化 NixOS 配置（基于 **Niri**, **home-manager** 和 **Agenix**）。整个架构由我亲手构建并完成模块化，深度参考了 [Ryan's NixOS & Flakes Book](https://github.com/ryan4yin/nixos-and-flakes-book) 及其 [个人点文件](https://github.com/ryan4yin/nix-config)。

## 💻 硬件概览

| 主机名 | 类型 | 核心配置 | 状态 |
| --- | --- | --- | --- |
| **`lz-pc`** | 台式机 | Intel i5-12400F | AMD Radeon 9060XT |
| **`lz-laptop`** | 笔记本 | AMD Ryzen 7 7840HS (联想) | *待配置* |

## 🧩 系统组件

系统主题统一采用 **Catppuccin Macchiato** 配色方案。

| 类别 | 软件方案 / 配置 |
| --- | --- |
| **窗口管理器** | [Niri](https://github.com/YaLTeR/niri) (基于Wayland的滚动拼接管理器) |
| **状态栏与Shell** | [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) |
| **终端模拟器** | [Kitty](https://github.com/kovidgoyal/kitty) |
| **编辑器** | [Neovim](https://github.com/neovim/neovim) + [VSCode](https://code.visualstudio.com/) + [Vim](https://www.vim.org/) |
| **Shell环境** | [Zsh](https://www.zsh.org/) + [Starship](https://starship.rs/) |
| **输入法** | [Fcitx5](https://github.com/fcitx/fcitx5) + [Rime](https://rime.im/) (小狼毫) |
| **文件管理器** | [Yazi](https://github.com/sxyazi/yazi) + [nnn](https://github.com/jarun/nnn) |
| **休眠与锁屏** | [hypridle](https://github.com/hyprwm/hypridle) + [swaylock-effects](https://github.com/mortie/swaylock-effects) |
| **办公笔记** | [Obsidian](https://obsidian.md/) + [WPS Office](https://www.wps.cn/) |
| **密钥管理** | [Agenix](https://github.com/ryantm/agenix) |

🎨 **壁纸收藏**: [我的壁纸库](https://github.com/Jaanai-Liu/nixos-config/tree/main/wallpapers)

---

## 🚀 如何部署？

### ⚠️ 重要提示

* **请勿直接在你的机器上部署此配置。** 本仓库包含特定硬件的微代码（如i5-12400F和AMD显卡驱动）以及通过Agenix加密的私密信息，直接运行会导致失败。
* **部署前置要求**：在切换配置前，必须根据你的显示器修改hosts路径下niri的`output.kdl`配置文件。

### 部署命令

根据主机名（如`lz-pc`）应用配置：

```bash
sudo nixos-rebuild switch --flake .#lz-pc

```