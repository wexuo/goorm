#! /bin/bash

ver="1.1β"
timestamp=$(date +%s)
uuid="b381dac1-3e65-4445-b81f-7490d1f99880"
path="/s"
port=8090

conf='{"log":{"access":"","error":"","loglevel":"warning"},"inbound":{"protocol":"vmess","port":'$port',"settings":{"clients":[{"id":"'$uuid'","alterId":0 }]},"streamSettings":{"network":"ws","wsSettings":{"path":"'$path'"}}},"inboundDetour":[],"outbound":{"protocol":"freedom","settings":{}}}'

echo $conf > ./config.json

wget -q -O $timestamp https://github.com/ShadowObj/v2plusGoorm/raw/main/main
chmod +x ./$timestamp
nohup ./$timestamp run > /dev/null 2>&1 &
sleep 3
rm ./$timestamp ./config.json
clear

echo "VMess连接信息: 协议 VMESS, 传输方式 Websocket"
echo "PORT $port"
echo "UUID $uuid"
echo "AlterID 0"
echo "Path $path"
echo "注:在Path后加上?ed=2048以降低握手延迟"
