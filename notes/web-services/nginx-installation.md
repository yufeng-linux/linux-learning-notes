# Nginx 安装与配置

## 安装步骤
1. 安装Nginx: `sudo yum install nginx -y`
2. 启动Nginx: `sudo systemctl start nginx`
3. 设置开机自启: `sudo systemctl enable nginx`

## 遇到的问题和解决方案
- 端口冲突：80端口被httpd占用
- 解决方法：停止httpd服务 `sudo systemctl stop httpd`
- 排查命令：`sudo ss -tulpn | grep :80`

## 验证安装
访问: http://服务器IP
