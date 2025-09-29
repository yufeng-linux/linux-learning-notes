#!/bin/bash

# 高级系统监控脚本
# 功能：收集系统资源使用情况并记录资源消耗最高的进程

# 定义日志文件位置
LOG_FILE="/var/log/system_monitor.log"

# 创建日志目录（如果不存在）
sudo mkdir -p $(dirname "$LOG_FILE")
sudo touch "$LOG_FILE"
sudo chmod 644 "$LOG_FILE"

# 获取当前时间
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 函数：检查系统负载
check_load() {
    echo "[$DATE] 系统负载情况:" | tee -a "$LOG_FILE"
    uptime | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
}

# 函数：检查内存使用
check_memory() {
    echo "[$DATE] 内存使用情况:" | tee -a "$LOG_FILE"
    free -h | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
}

# 函数：检查磁盘空间
check_disk() {
    echo "[$DATE] 磁盘空间使用情况:" | tee -a "$LOG_FILE"
    df -h | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
}

# 函数：检查资源消耗最高的进程
check_top_processes() {
    echo "[$DATE] --- Top 5 CPU 消耗进程 ---" | tee -a "$LOG_FILE"
    ps aux --sort=-%cpu | head -6 | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "[$DATE] --- Top 5 内存消耗进程 ---" | tee -a "$LOG_FILE"
    ps aux --sort=-%mem | head -6 | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
}

# 主逻辑
echo "==================================" | tee -a "$LOG_FILE"
check_load
check_memory
check_disk
check_top_processes
echo "监控日志已保存至: $LOG_FILE"
