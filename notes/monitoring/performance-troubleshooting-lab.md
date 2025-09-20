i# 性能诊断案例

## 制造负载命令
dd if=/dev/zero of=/dev/null bs=1M count=1000000 &
stress --vm 1 --vm-bytes 500M --timeout 60s &

## 诊断命令
htop
ps aux --sort=-%cpu | head -5
ps aux --sort=-%mem | head -5

## 终止进程
kill PID号
kill -9 PID号
