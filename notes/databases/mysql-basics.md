第十三天学习笔记：MySQL数据库操作与PHP连接

📅 学习日期

2025年9月24日

🎯 今日学习目标

掌握MySQL基本操作，并实现PHP与数据库的连接，创建动态数据驱动的网站。

✅ 完成情况

全部目标已完成！ 🎉

📖 学习内容总结

1. MySQL数据库基础操作

创建数据库和用户

```sql
-- 创建数据库
CREATE DATABASE my_web_app;

-- 创建专用用户
CREATE USER 'web_user'@'localhost' IDENTIFIED BY 'WebPassword123!';

-- 授予权限
GRANT ALL PRIVILEGES ON my_web_app.* TO 'web_user'@'localhost';
FLUSH PRIVILEGES;
```

创建数据表

```sql
-- 用户表
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 留言表
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

常用SQL命令练习

```sql
-- 插入数据
INSERT INTO users (name, email) VALUES ('张三', 'zhangsan@example.com');

-- 查询数据
SELECT * FROM users WHERE name LIKE '张%';

-- 更新数据
UPDATE users SET email = 'zhangsan_new@example.com' WHERE name = '张三';

-- 删除数据
DELETE FROM users WHERE name = '王五';
```

2. PHP连接MySQL数据库

数据库连接配置

```php
<?php
// 数据库配置
$servername = "localhost";
$username = "web_user";
$password = "WebPassword123!";
$dbname = "my_web_app";

// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);

// 检查连接
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
}

// 设置字符集（重要！解决中文乱码）
$conn->set_charset("utf8mb4");
?>
```

执行查询和显示数据

```php
// 执行查询
$sql = "SELECT id, name, email, created_at FROM users";
$result = $conn->query($sql);

// 处理结果
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"] . " - 姓名: " . $row["name"];
    }
} else {
    echo "没有找到数据";
}

// 关闭连接
$conn->close();
```

3. 完整留言板应用实现

关键功能代码

```php
// 处理表单提交
if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_POST['action'] == 'add') {
    $username_input = $conn->real_escape_string($_POST['username']);
    $message = $conn->real_escape_string($_POST['message']);
    
    $sql = "INSERT INTO messages (username, message) VALUES ('$username_input', '$message')";
    $conn->query($sql);
}

// 显示留言
$sql = "SELECT username, message, created_at FROM messages ORDER BY created_at DESC";
$result = $conn->query($sql);
```

🐛 遇到的问题及解决方案

问题1：中文显示乱码（显示为"??"）

解决方案：在数据库连接后添加字符集设置

```php
$conn->set_charset("utf8mb4");
```

问题2：MySQL服务找不到

原因：系统使用的是MariaDB而不是MySQL 解决方案：

```bash
# 检查并启动MariaDB服务
sudo systemctl status mariadb
sudo systemctl start mariadb
```

问题3：SQL命令在Linux终端中执行错误

原因：混淆了Linux命令和SQL命令的执行环境 解决方案：

· SQL命令必须在MySQL客户端中执行
· Linux命令在系统终端中执行

问题4：文件权限和路径问题

解决方案：

```bash
# 使用正确路径
sudo vim /usr/share/nginx/php-site/db-test.php

# 检查文件权限
sudo chown www-data:www-data /usr/share/nginx/php-site/
```

💡 重要知识点总结

数据库设计原则

· 每个表应有主键（通常使用AUTO_INCREMENT）
· 合理选择字段类型和长度
· 使用时间戳记录数据创建时间
· 为重要字段设置NOT NULL约束

PHP与MySQL交互安全

· 使用专用数据库用户，避免使用root
· 对用户输入进行转义：$conn->real_escape_string()
· 设置正确的字符集防止乱码
· （后续学习）使用预处理语句防止SQL注入

Web应用数据流

```
用户输入 → PHP接收处理 → 数据库存储 → PHP查询 → 页面显示
```

🎯 实际项目成果

1. 数据库连接测试页面 (db-test.php)

· 成功连接数据库
· 显示用户数据表格
· 解决中文显示问题

2. 简单留言板应用 (guestbook.php)

· 完整的CRUD功能（增删改查）
· 表单数据验证和处理
· 动态数据展示
· 时间戳记录

📈 学习收获

1. 掌握了MySQL基础操作：能够独立创建数据库、表结构，执行基本SQL操作
2. 实现了PHP与数据库集成：理解了动态网站的数据持久化机制
3. 解决了实际问题：学会了诊断和解决中文乱码等常见问题
4. 完成了完整项目：从数据库设计到前端展示的完整开发流程

🚀 下一步学习建议

1. 学习预处理语句提高数据库操作安全性
2. 实现用户认证系统（登录、注册、会话管理）
3. 学习数据分页和搜索功能
4. 尝试部署实际应用（如WordPress）
5. 学习数据库优化和索引

📝 代码文件清单

· /usr/share/nginx/php-site/db-test.php - 数据库连接测试
· /usr/share/nginx/php-site/guestbook.php - 留言板应用

---

今日总结：成功跨越了Web开发的重要门槛，掌握了数据驱动网站的核心技术！从静态页面升级到了真正的动态应用开发能力。
