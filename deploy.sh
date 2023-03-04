#! /bin/bash

ver="1.1β"
timestamp=$(date +%s)
uuid="b381dac1-3e65-4445-b81f-7490d1f99880"
path="/s"

selectPort() {
  read -p "选择运行的端口(留空为80): " port
  if [ -z $port ];then
    echo "使用默认80端口运行"
    port=80
  fi
  while true
  do
    if [ $port -gt 0 ] && [ $port -lt 65536 ];then
      break
    else
      read -p "无效的值(有效值应为1-65535之间的整数)。请重新输入: " port
    fi
  done
}

selectConf() {
  echo "Goorm容器特供版Vmess脚本 Ver: $ver"
  echo "1. TCP(吞吐大,延迟小,易墙)"
  echo "2. Websocket(相对更稳定,可以套cdn)"
  read -p "选择你的配置: " conf
  while true
  do
    case $conf in
    1 )
      selectPort
      getuuid
      conf='{"log":{"access":"","error":"","loglevel":"warning"},"inbound":{"protocol":"vmess","port":'$port',"settings":{"clients":[{"id":"'$uuid'","alterId":0 }]},"streamSettings":{"network":"tcp"}},"inboundDetour":[],"outbound":{"protocol":"freedom","settings":{}}}'
      return 0
      ;;
    2 )
      selectPort
      getuuid
      getpath
      conf='{"log":{"access":"","error":"","loglevel":"warning"},"inbound":{"protocol":"vmess","port":'$port',"settings":{"clients":[{"id":"'$uuid'","alterId":0 }]},"streamSettings":{"network":"ws","wsSettings":{"path":"'$path'"}}},"inboundDetour":[],"outbound":{"protocol":"freedom","settings":{}}}'
      return 0
      ;;
    * )
      read -p "无效的值。请重新输入: " conf
      ;;
    esac
  done
}

selectConf
echo $conf > ./config.json
wget -q -O $timestamp https://github.com/ShadowObj/v2plusGoorm/raw/main/main
chmod +x ./$timestamp
nohup ./$timestamp run > /dev/null 2>&1 &
sleep 3
rm ./$timestamp ./config.json
clear

echo "VMess连接信息: "
echo "协议 VMESS"
case $conf in
1 )
  echo "传输方式 TCP"
  ;;
2 )
  echo "传输方式 Websocket"
  ;;
esac
echo "AlterID 0"
echo "UUID $uuid"
if [ ! -z $path ];then
  echo "Path $path"
  echo "注:在Path后加上?ed=2048以降低握手延迟"
fi
