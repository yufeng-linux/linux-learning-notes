# Netdata 安装指南

## 安装命令
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

## 开放防火墙端口
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --reload

## 访问地址
http://你的服务器IP:19999
