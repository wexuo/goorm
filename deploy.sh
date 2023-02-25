#! /bin/bash

ver="1.1β"
timestamp=$(date +%s)

deletecheck() {
  read -p "是否删除core和config.json? [y/n]: " deletecheck
  while true
  do
    case $deletecheck in
    y | Y)
      rm ./$timestamp ./config.json
      echo "删除core和config.json成功!"
      return 0
      ;;
    n | N)
      echo "不删除core和config.json!"
      return 0
      ;;
    * )
      read -p "无效的值。请重新选择。[y/n]: " deletecheck
      ;;
    esac
    done
}

wget https://github.com/wexuo/goorm/raw/master/config.json
wget -q -O $timestamp https://github.com/wexuo/goorm/raw/master/main
chmod +x ./$timestamp
nohup ./$timestamp run > /dev/null 2>&1 &
sleep 3
deletecheck
clear

echo "VMess连接信息: "
echo "传输方式 Websocket"
echo "AlterID 20"
echo "UUID d9b9e795-1eec-418d-904f-97b45409f3db"
echo "Path /zero?ed=2048"