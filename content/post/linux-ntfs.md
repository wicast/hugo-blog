+++
comments = true
date = "2015-08-09T02:30:02+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["Linux","Tips"]
title = "Linux 中使用普通用户开机挂载 NTFS 分区（免密码）"

+++

以前在 cubieboard 的时候都是在 fstab 里面写死了怎么挂载 NTFS，后来用了 Manjaro 发现可以用 gvfs 实现用户挂载。前一阵的 Manjaro 因为 SSD 坏块挂了，这两天干脆重了装原版 arch，发现 gvfs 默认情况下还需要密码才能挂载 NTFS……

<!--more-->

查询一番资料发现 Manjaro 原来修改了 udisk2 的 polkit 默认策略……
https://forum.manjaro.org/index.php?topic=238.msg1284#msg1284

##### 具体操作
总之 gvfs 和 ntfs-3g 肯定是要的。
`pacman -S gvfs ntfs-3g`

如果像咱一样用的是 DE，那么文件管理器里面应该就能看到 NTFS 的设备了，不过这时候如果试图挂载是会弹认证的。此外那种外置 USB 存储应该也能自动识别了吧。WM 用户可能需要进一步调教。

gvfs 本身调用的是 udisk2，所以在把 udisk2 的 polkit 修改一下就能免密码挂载了。

在 `/usr/share/polkit-1/actions/org.freedesktop.udisks2.policy` 这个文件，找到 `<action id="org.freedesktop.udisks2.filesystem-mount-system">` 在这段最下面的

      <allow_inactive>auth_admin</allow_inactive>
      <allow_active>auth_admin_keep</allow_active>

把 `auth_admin` 和 `auth_admin_keep` 都改成 `yes` 保存重启应该就能免密码挂载 NTFS 了。

最后把 `gvfs -d /dev/sdXN` 加到开机执行脚本即可使得每次开机就挂载。