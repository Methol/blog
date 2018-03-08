---
title: "防止iPhone自动下载iOS11升级"
date: 2018-01-24 14:10:55
tags: [iPhone]
---



### 安装tvOS Beta描述文件

使用 iOS 端的 Safari 浏览器点击  **[https://tuzhihao.com/upload/tvos/tvos11.mobileconfig](https://tuzhihao.com/upload/tvos/tvos11.mobileconfig)** 安装，或是使用 PC 下载后邮件发送到 iOS 设备，用自带的 Mail 打开也可安装。安装完成后重启手机，便不会再收到任何的系统更新了。

## 屏蔽更新的原理

安装了`tvOS 11 Beta Software Profile`，设备便会去检测 tvOS 10 Beta 版的更新，显而易见的是，tvOS 系统仅能适用于 Apple TV，iOS 设备安装该描述文件后，检测到的更新无法适用，便会显示 : 您的软件是最新版本。

## 注意事项

1. 该描述文件能用到2019年，估计到时候应该有tvOS 12的Beta文件了。

2. 如果之前装了可以升级测试版系统的描述文件，删除原来安装的描述文件，再安装本文件。

3. 安装之后连接 iTunes 时依然会提示有系统更新，忽略即可。

4. 已经自动下载好安装包的用户，可以进入设置——通用里面，找到【储存空间与iCloud用量】——【管理储存空间与iCloud用量】里面删除掉已安装的升级包，然后再安装描述文件。

   ​