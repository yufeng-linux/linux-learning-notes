#!/bin/bash

# 安全监控脚本
echo "=== 系统安全监控报告 ==="
echo "生成时间: $(date)"
echo ""

echo "--- 最近安全事件 ---"
echo "1. 最近登录失败:"
sudo grep "Failed password" /var/log/secure | tail -5
echo ""

echo "2. 最近成功登录:"
sudo grep "Accepted password" /var/log/secure | tail -3
echo ""

echo "--- 系统状态 ---"
echo "3. 当前登录用户:"
who
echo ""

echo "4. 系统资源:"
echo "内存:"
free -h | grep Mem:
echo "负载:"
uptime
echo ""

echo "--- 网络连接 ---"
echo "5. 监听端口:"
sudo netstat -tulpn | grep LISTEN | head -10
echo ""

echo "--- Web访问统计 ---"
echo "6. 最近Web访问:"
sudo tail -10 /var/log/nginx/access.log 2>/dev/null || echo "Nginx访问日志不可用"
echo ""

echo "--- fail2ban状态 ---"
sudo fail2ban-client status sshd 2>/dev/null | grep -E "Status|Total banned" || echo "fail2ban未运行"

echo ""
echo "监控报告生成完成"
