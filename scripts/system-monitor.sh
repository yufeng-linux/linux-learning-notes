#!/bin/bash
echo "=== 系统监控报告 ==="
echo "生成时间: $(date)"
echo ""
echo "--- 内存使用情况 ---"
free -h
echo ""
echo "--- 磁盘使用情况 ---"
df -h
