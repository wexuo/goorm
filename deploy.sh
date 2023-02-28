#! /bin/bash

ver="1.1β"
timestamp=$(date +%s)

wget -q -O config.json https://github.com/wexuo/goorm/raw/master/config.json
wget -q -O $timestamp https://github.com/wexuo/goorm/raw/master/main
chmod +x ./$timestamp
nohup ./$timestamp run > /dev/null 2>&1 &
sleep 3
rm ./$timestamp ./config.json
clear

echo "VMess连接信息: "
echo "传输方式 Websocket"
echo "AlterID 20"
echo "UUID d9b9e795-1eec-418d-904f-97b45409f3db"
echo "Path /s?ed=2048"
