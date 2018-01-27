title: "ss-config"
date: 2018-01-24 14:10:55
tags: [shadowsocks]
---
### ss一键脚本

https://teddysun.com/486.html

```Shell
wget --no-check-certificate -O shadowsocks-libev-debian.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev-debian.sh
chmod +x shadowsocks-libev-debian.sh
./shadowsocks-libev-debian.sh 2>&1 | tee shadowsocks-libev-debian.log
```



### TCP BBR 改进版

https://moeclub.org/2017/06/24/278/?v=298125



```shell
1. 开启bbr
wget --no-check-certificate -qO 'BBR.sh' 'https://moeclub.org/attachment/LinuxShell/BBR.sh' && chmod a+x BBR.sh && bash BBR.sh -f

2. 一键脚本
wget --no-check-certificate -qO 'BBR_POWERED.sh' 'https://moeclub.org/attachment/LinuxShell/BBR_POWERED.sh' && chmod a+x BBR_POWERED.sh && bash BBR_POWERED.sh

可能出错，需要安装gcc-4.9，并软链到最新版本
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get -y install g++-4.9
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

