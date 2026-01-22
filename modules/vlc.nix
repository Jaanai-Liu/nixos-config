# modules/vlc.nix
{ config, pkgs, ... }:

{
  home.packages = [ pkgs.vlc ];
  
  # 直接修改 VLC 的配置文件 vlcrc
  home.file.".config/vlc/vlcrc".text = ''
    # 弹窗禁止
    qt-privacy-ask=0

    # network
    metadata-network-access=1

    ### 自动恢复播放进度
    # 0 = 从不, 1 = 询问, 2 = 总是
    qt-continue=2
    
    [core]
    # 自动优先选择中文字幕
    sub-language=chi,zh,zh-cn,chs,sc
    
    # 自动优先选择中文音轨（可选，建议也加上）
    audio-language=chi,zh,zh-cn,chs,sc

    # 自动检测并加载同名字幕文件
    sub-autodetect-file=1
    # 模糊匹配字幕（例如视频名和字幕名不完全一致时也能加载）
    sub-autodetect-fuzzy=1
  '';
}
