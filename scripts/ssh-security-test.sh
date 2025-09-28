#!/bin/bash

SERVER_IP="192.168.200.152"  # 替换为你的IP
SSH_PORT="2222"                # 如果改了端口，这里也要改

echo "=== SSH安全测试 ==="
echo "测试目标: $SERVER_IP"
echo "SSH端口: $SSH_PORT"
echo ""

# 测试普通用户连接
echo "1. 测试普通用户连接..."
if ssh -o ConnectTimeout=5 -o BatchMode=yes -p $SSH_PORT wyf@$SERVER_IP "echo '连接成功'" &>/dev/null; then
    echo "✅ 普通用户连接成功"
else
    echo "❌ 普通用户连接失败"
fi

echo ""

# 测试root用户连接（应该失败）
echo "2. 测试root用户连接（应该失败）..."
if ssh -o ConnectTimeout=5 -o BatchMode=yes -p $SSH_PORT root@$SERVER_IP "echo '不应该成功'" &>/dev/null; then
    echo "❌ 安全风险：root用户可以直接登录！"
else
    echo "✅ root用户登录被正确拒绝"
fi

echo ""

# 检查SSH配置
echo "3. 检查SSH配置..."
if sudo sshd -t &>/dev/null; then
    echo "✅ SSH配置语法正确"
else
    echo "❌ SSH配置有语法错误"
fi

echo ""
echo "测试完成"
