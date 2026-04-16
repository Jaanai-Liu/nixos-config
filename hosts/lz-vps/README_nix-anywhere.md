````markdown
# NixOS-Anywhere Installation Guide for Low-RAM & Network-Restricted VPS (ZRAM Method)

This guide provides a bulletproof workflow for installing NixOS on low-memory Virtual Private Servers (VPS), such as those with only 1GB of RAM. It also covers workarounds for servers with restricted network access to GitHub (e.g., domestic servers in China). Standard `nixos-anywhere` installations often fail on such machines due to Out-Of-Memory (OOM) errors, garbage collection (GC) loops, or network timeouts when transferring the system closure.

This workflow solves the issue by splitting the installation into phases, utilizing local computation, and creating a temporary ZRAM swap space in the Live environment.

## Method 1: Standard kexec (For VPS with Good GitHub Connection)

_Use this method for overseas servers (e.g., in Los Angeles) that can quickly download files directly from GitHub._

### **Step 1: Preparation & SSH Key Management**

Clear the old SSH record to prevent host key mismatch errors:

```bash
ssh-keygen -R <YOUR_VPS_IP>
```
````

### **Step 2: Inject NixOS Memory System (kexec phase)**

Replace the existing OS with a minimal NixOS Live environment running in RAM.

```bash
nix run github:nix-community/nixos-anywhere -- --phases kexec --flake .#<YOUR_FLAKE_HOST> root@<YOUR_VPS_IP> --no-substitute-on-destination
```

_(Wait 1-2 minutes for the connection to drop and the VPS to reboot into memory)._

### **Step 3: Enable ZRAM Extreme Expansion (Optional but recommended for <2GB RAM)**

Connect to the VPS (`ssh root@<YOUR_VPS_IP>`) and run:

```bash
mount -o remount,size=2G /nix/.rw-store
modprobe zram
echo zstd > /sys/block/zram0/comp_algorithm
echo 1500M > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon /dev/zram0
exit
```

### **Step 4: Execute Disk Formatting and Installation**

Push the final system from your local machine:

```bash
nix run github:nix-community/nixos-anywhere -- --phases disko,install --flake .#<YOUR_FLAKE_HOST> root@<YOUR_VPS_IP> --no-substitute-on-destination
```

---

## Method 2: Manual kexec (For Domestic Servers with Poor GitHub Connection)

_Use this method for servers in China (e.g., Aliyun, Tencent Cloud) where `nixos-anywhere` gets stuck downloading the `kexec` tarball or encounters `Scheme missing` errors._

### **Step 1: Download the kexec image locally**

Download the tarball to your local machine (using a proxy or a mirror).

```bash
# Example using a mirror:
curl -L [https://mirror.ghproxy.com/https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz](https://mirror.ghproxy.com/https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz) -o nixos-kexec.tar.gz
```

### **Step 2: SCP the image to the VPS**

Upload the file manually to bypass the server's poor download speed:

```bash
scp ./nixos-kexec.tar.gz root@<YOUR_VPS_IP>:/root/
```

### **Step 3: Trigger kexec manually via SSH**

SSH into the server and execute the kexec script directly to replace the OS in memory. The SSH connection will drop immediately after running this.

```bash
ssh root@<YOUR_VPS_IP> "mkdir -p /root/kexec && tar -zxf /root/nixos-kexec.tar.gz -C /root/kexec && /root/kexec/kexec/run"
```

_(Wait 1-2 minutes, clear your local SSH known_hosts using `ssh-keygen -R <YOUR_VPS_IP>`, and optionally log back in to set up ZRAM as shown in Method 1, Step 3)._

### **Step 4: Execute Disk Formatting and Installation**

Once the server is running the NixOS memory environment, execute the final installation phase locally:

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#<YOUR_FLAKE_HOST> \
  --phases disko,install \
  --no-substitute-on-destination \
  root@<YOUR_VPS_IP>
```

---

---

# 低内存及受限网络 VPS 上 NixOS Anywhere 安装指南 (ZRAM 方案)

本指南提供了一套针对低内存 VPS（如 1GB 内存）及连接 GitHub 网络较差的机器（如国内阿里云、腾讯云）安装 NixOS 的完美工作流。在这些机器上直接运行 `nixos-anywhere` 通常会因为内存耗尽 (OOM)、触发垃圾回收 (GC) 死循环或网络下载超时而导致安装失败。

本方案通过分步执行、利用本地算力代工，以及在内存系统中开启 ZRAM 虚拟内存或手动推送镜像，完美解决了上述卡死问题。

## 方法一：标准 kexec 流程（适用于连接 GitHub 网络良好的海外 VPS）

### **第一步：准备工作与 SSH 密钥管理**

清除旧的 SSH 记录，防止指纹不匹配报错：

```bash
ssh-keygen -R <你的VPS_IP>
```

### **第二步：注入 NixOS 内存系统 (kexec 阶段)**

在本地电脑上执行，仅加载内存系统：

```bash
nix run github:nix-community/nixos-anywhere -- --phases kexec --flake .#<你的主机名> root@<你的VPS_IP> --no-substitute-on-destination
```

### **第三步：SSH 登录并开启 ZRAM 极限扩容（2GB 以下内存强烈建议）**

登录服务器 (`ssh root@<你的VPS_IP>`) 并逐行执行：

```bash
mount -o remount,size=2G /nix/.rw-store
modprobe zram
echo zstd > /sys/block/zram0/comp_algorithm
echo 1500M > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon /dev/zram0
exit
```

### **第四步：执行硬盘分区与系统安装**

回到本地电脑上执行最后的推送与安装：

```bash
nix run github:nix-community/nixos-anywhere -- --phases disko,install --flake .#<你的主机名> root@<你的VPS_IP> --no-substitute-on-destination
```

---

## 方法二：手动 kexec 流程（适用于国内云服务器等连接 GitHub 极慢的 VPS）

_当自动化工具在 `Downloading kexec tarball...` 卡死，或尝试使用本地路径报错 `Scheme missing` 时，请使用此手动“夺舍”方案。_

### **第一步：在本地下载 kexec 镜像文件**

利用你本地的网络（或加速站）将镜像下载到本地目录：

```bash
curl -L [https://mirror.ghproxy.com/https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz](https://mirror.ghproxy.com/https://github.com/nix-community/nixos-images/releases/download/nixos-25.05/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz) -o nixos-kexec.tar.gz
```

### **第二步：通过 SCP 将镜像手动推送到服务器**

将下载好的系统镜像直接推送到国内服务器的 `/root` 目录下，彻底避开服务器端 wget 的网络波动：

```bash
scp ./nixos-kexec.tar.gz root@<你的VPS_IP>:/root/
```

### **第三步：SSH 登录并手动触发 kexec (夺舍)**

一条命令完成解压并触发内核替换。执行后 SSH 连接会立刻断开，表明服务器正在内存中重启进入 NixOS Live 环境：

```bash
ssh root@<你的VPS_IP> "mkdir -p /root/kexec && tar -zxf /root/nixos-kexec.tar.gz -C /root/kexec && /root/kexec/kexec/run"
```

_（等待 1-2 分钟，执行 `ssh-keygen -R <你的VPS_IP>` 清除旧指纹。如果内存较小，可此时登录进去执行 方法一、第三步 的 ZRAM 扩容指令）。_

### **第四步：执行硬盘分区与系统安装**

在本地执行安装指令，跳过 kexec 阶段，直接开始执行 disko 分区和系统闭包拷贝：

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#<你的主机名> \
  --phases disko,install \
  --no-substitute-on-destination \
  root@<你的VPS_IP>
```

```

```
