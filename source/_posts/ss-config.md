---
title: "ss-config"
date: 2018-01-24 14:10:55
tags: [shadowsocks]
---



### 基础环境设置

```shell
# 安装git和zsh
apt update
apt install git zsh iftop lrzsz curl supervisor vim

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 安装字符集
apt-get -y install language-pack-zh-hans

# 安装服务器监控
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/status.sh && chmod +x status.sh
# 客户端
./status.sh c
wget http://static.tuzhihao.com/status-client.py -O status-client.py
# 服务端
./status.sh s

# prometheus
wget http://static.tuzhihao.com/prometheus/node_exporter
chmod +x node_exporter
vi /etc/init/node_exporter.conf
# Run node_exporter

start on startup

script
   /root/node_exporter
end script



vi /etc/rc.local
bash /root/reboot.sh


# 服务器性能测试
curl -Lso- bench.sh | bash
```



### 服务器性能测试

```
# 91yun
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/91yuntest/master/test.sh && bash test.sh -i "io,bandwidth,download,traceroute,backtraceroute,allping,gotoping" -u

# 另一家
curl -Lso- bench.sh | bash
```





### 卸载阿里云盾监控

> https://github.com/ssrpanel/SSRPanel/wiki/%E5%8D%B8%E8%BD%BD%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%BE%E7%9B%91%E6%8E%A7&%E5%B1%8F%E8%94%BD%E4%BA%91%E7%9B%BEIP



```shell
wget http://update.aegis.aliyun.com/download/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh

wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
chmod +x quartz_uninstall.sh
./quartz_uninstall.sh

pkill aliyun-service
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*

```



### ss一键脚本

https://teddysun.com/486.html

```Shell
wget --no-check-certificate -O shadowsocks-libev-debian.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev-debian.sh
chmod +x shadowsocks-libev-debian.sh
./shadowsocks-libev-debian.sh 2>&1 | tee shadowsocks-libev-debian.log

# 更新启动配置
vi /etc/init.d/shadowsocks
```

### 锐速

http://xiaofd.win/onekey-ruisu.html

https://moeclub.org/2017/03/08/14/?v=198

```shell
# 一键脚本 14.04系统
wget xiaofd.github.io/ruisu.sh && bash ruisu.sh

# 确认是否运行
ps aux | grep appex

# 更新
bash /appex/bin/serverSpeeder.sh update

# 自定义带宽
bash /appex/bin/serverSpeeder.sh renewLic 1000G

启动命令 /appex/bin/serverSpeeder.sh start
停止加速 /appex/bin/serverSpeeder.sh stop
状态查询 /appex/bin/serverSpeeder.sh status
更新许可 /appex/bin/serverSpeeder.sh renewLic
重新启动 /appex/bin/serverSpeeder.sh restart
```



### TCP BBR 改进版

https://moeclub.org/2017/06/24/278/?v=298125



```shell
1. 开启bbr
wget --no-check-certificate -qO 'BBR.sh' 'https://moeclub.org/attachment/LinuxShell/BBR.sh' && chmod a+x BBR.sh && bash BBR.sh -f

2. 一键脚本
wget --no-check-certificate -qO 'BBR_POWERED.sh' 'https://moeclub.org/attachment/LinuxShell/BBR_POWERED.sh' && chmod a+x BBR_POWERED.sh && bash BBR_POWERED.sh

可能出错，需要安装gcc-4.9，并软链到最新版本
apt-get install -y software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get -y install g++-4.9
```



### 管理面板搭建

```
git clone https://github.com/gyteng/shadowsocks-manager-tiny.git

# 安装node
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
```



### 关闭bt端口

```Shell
#!/bin/bash

other_port="24,50,57,105,106,158,209,587,1109,24554,60177,60179"
key_word=(Subject HELO SMTP
    "torrent" ".torrent" "peer_id=" "announce"
    "info_hash" "get_peers" "find_node"
    "BitTorrent" "announce_peer"
    "BitTorrent protocol" "announce.php?passkey=")
 
v4iptables=`which iptables 2>/dev/null`
v6iptables=`which ip6tables 2>/dev/null`
 
cat_rules() {
    $1 -t $2 -L OUTPUT -nvx --line-numbers
}
 
mangle_key_word() {
    $1 -t mangle -A OUTPUT -m string --string "$2" --algo bm --to 65535 -j DROP
}
 
tcp_port_DROP() {
    [ "$1" = "$v4iptables" ] && \
        $1 -t filter -A OUTPUT -p tcp -m multiport --dports $2 -m state --state NEW,ESTABLISHED -j REJECT --reject-with icmp-port-unreachable || \
        $1 -t filter -A OUTPUT -p tcp -m multiport --dports $2 -m state --state NEW,ESTABLISHED -j REJECT --reject-with tcp-reset
}
 
udp_port_drop() {
    $1 -t filter -A OUTPUT -p udp -m multiport --dports $2 -j DROP
}
 
if [ -n "$v4iptables" -a -n "$v6iptables" ]; then
    for i in ${key_word[@]}; do for j in $v4iptables $v6iptables; do mangle_key_word $j $i; done; done
    for i in ${other_port}; do for j in $v4iptables $v6iptables; do tcp_port_DROP $j $i && udp_port_drop $j $i; done; done
    clear && for i in $v4iptables $v6iptables; do for j in filter mangle; do cat_rules $i $j; done; done
elif [ -n "$v4iptables" ]; then
    for i in ${key_word[@]}; do mangle_key_word $v4iptables $i;done
    for i in ${other_port}; do tcp_port_DROP $v4iptables $i && udp_port_drop $v4iptables $i; done
    clear && for i in filter mangle; do cat_rules $v4iptables $i;done
else
    echo "Your system don't find iptables"
fi
```



### ss加密算法性能测试

```
#!/bin/bash

method=aes-256-gcm

ss-tunnel -k test -m $method -l 2001 -L 127.0.0.1:2002 -s 127.0.0.1 -p 2003 &
ss_tunnel_pid=$!
ss-server -k test -m $method -s 127.0.0.1 -p 2003 &
ss_server_pid=$!

iperf -s -p 2002 &
iperf_pid=$!

sleep 60

iperf -c 127.0.0.1 -p 2001

kill $ss_tunnel_pid
kill $ss_server_pid
kill $iperf_pid

echo "finished"

```



