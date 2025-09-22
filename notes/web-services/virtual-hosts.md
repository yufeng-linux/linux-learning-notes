枫:
# 创建学习笔记
vim ~/learning-linux/notes/web-services/virtual-hosts.md

枫:
### 什么是虚拟主机？
- 就像一套房子里隔出多个房间，每个房间可以租给不同的租户
- 一台服务器通过配置，可以让多个域名指向不同的网站内容
- 用户访问不同域名时，看到的是完全不同的网站

枫:
### 配置步骤

#### 1. 创建网站目录
**目的**：为每个虚拟主机创建独立的"房间"
```bash
sudo mkdir -p /usr/share/nginx/test-site1
sudo mkdir -p /usr/share/nginx/test-site2

枫:
### 遇到的问题

#### 问题1：Nginx配置测试失败
**错误信息**：`nginx: [emerg] unknown directive "servr_name"`
**原因**：拼写错误，应该是`server_name`而不是`servr_name`
**解决**：仔细检查拼写，修改后重新测试

枫:
### 测试验证
1. 在hosts文件中添加域名映射
2. 浏览器访问`test-site1.com` → 显示蓝色背景的网站
3. 浏览器访问`test-site2.com` → 显示橙色背景的网站
✅ 虚拟主机配置成功！

枫:
### 常用命令总结
| 命令 | 用途 | 示例 |
|------|------|------|
| `sudo nginx -t` | 测试Nginx配置语法 | `sudo nginx -t` |
| `sudo systemctl reload nginx` | 重载配置（不重启） | `sudo systemctl reload nginx` |

枫:
### 明日计划
- 学习LNMP环境搭建（Linux + Nginx + MySQL + PHP）
- 尝试部署WordPress博客系统

