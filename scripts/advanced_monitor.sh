#!/bin/bash

# 脚本配置
LOG_DIR="$HOME/monitor_logs"
LOG_FILE="$LOG_DIR/system_monitor_$(date +%Y%m%d).log"
INTERVAL=300  # 监控间隔（秒）

# 创建日志目录
mkdir -p "$LOG_DIR"

# 函数：记录时间戳
log_timestamp() {
    echo "==========================================" | tee -a "$LOG_FILE"
    echo "监控时间: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG_FILE"
    echo "==========================================" | tee -a "$LOG_FILE"
}

# 函数：检查系统负载
check_load() {
    echo "--- 系统负载 ---" | tee -a "$LOG_FILE"
    uptime | tee -a "$LOG_FILE"
}

# 函数：检查内存使用
check_memory() {
    echo "--- 内存使用 ---" | tee -a "$LOG_FILE"
    free -h | tee -a "$LOG_FILE"
}

# 函数：检查磁盘空间
check_disk() {
    echo "--- 磁盘空间 ---" | tee -a "$LOG_FILE"
    df -h | tee -a "$LOG_FILE"
}

# 函数：检查资源消耗最高的进程
check_top_processes() {
    echo "--- Top 5 CPU 消耗进程 ---" | tee -a "$LOG_FILE"
    ps aux --sort=-%cpu | head -6 | tee -a "$LOG_FILE"
    
    echo "" | tee -a "$LOG_FILE"
    echo "--- Top 5 内存消耗进程 ---" | tee -a "$LOG_FILE"
    ps aux --sort=-%mem | head -6 | tee -a "$LOG_FILE"
}

# 函数：检查命令是否执行成功
check_command_status() {
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] $1" | tee -a "$LOG_FILE"
    else
        echo "[ERROR] $1 - Exit code: $?" | tee -a "$LOG_FILE"
        # 可以在这里添加报警逻辑，比如发送邮件
    fi
}

# 函数：检查磁盘空间使用率是否超过阈值
check_disk_usage() {
    local threshold=80
    echo "--- 检查磁盘空间（阈值：${threshold}%） ---" | tee -a "$LOG_FILE"
    
    # 使用awk找出使用率超过阈值的分区
    df -h | awk -v threshold=$threshold '
        $1 !~ /^(\/dev\/sr|tmpfs|devtmpfs)/ && $5+0 > threshold {
            print "警告：分区 " $1 " (" $6 ") 使用率 " $5 " > " threshold "%"
        }' | tee -a "$LOG_FILE"
}

# 函数：检查关键服务是否在运行
check_service_status() {
    local service_name=$1
    echo "--- 检查服务：$service_name ---" | tee -a "$LOG_FILE"

    systemctl is-active --quiet "$service_name"
    if [ $? -eq 0 ]; then
        echo "服务状态：运行中" | tee -a "$LOG_FILE"
    else
        echo "服务状态：未运行" | tee -a "$LOG_FILE"
    fi
    check_command_status "检查服务状态：$service_name"
}

# 主监控逻辑
main_monitor() {
    log_timestamp
    check_load
    check_memory
    check_disk
    check_top_processes
    check_disk_usage
    check_service_status "netdata"  # 检查netdata服务
    check_service_status "sshd"     # 检查SSH服务
    echo -e "\n\n" | tee -a "$LOG_FILE"
}

# 执行监控
echo "开始系统监控，日志文件: $LOG_FILE"
echo "按 Ctrl+C 停止监控"

# 先执行一次监控
main_monitor

# 循环执行监控（可选）
# while true; do
#     main_monitor
#     sleep $INTERVAL
# done

