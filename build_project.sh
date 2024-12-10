#!/bin/bash

# 提示用户输入项目名称
read -p "输入你要生成的项目名: " PROJECT_NAME

# 转换为小写，用于包名
PACKAGE_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')

# 转换为大写首字母，用于类名
CLASS_NAME=$(echo "$PROJECT_NAME" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

# 检查是否在项目根目录
if [ -d "$PROJECT_NAME" ]; then
    echo "项目目录 '$PROJECT_NAME' 已存在。"
    read -p "是否覆盖现有目录？(y/n): " choice
    case "$choice" in
        y|Y ) rm -rf "$PROJECT_NAME";;
        * ) echo "脚本终止。"; exit 1;;
    esac
fi

# 创建项目根目录和必要的子目录
BASE_DIR="$PROJECT_NAME/src/main/java/org/jackasher/$PACKAGE_NAME"
TEST_DIR="$PROJECT_NAME/src/test/java/org/jackasher/$PACKAGE_NAME"

mkdir -p "$BASE_DIR/controller"
mkdir -p "$BASE_DIR/filter"
mkdir -p "$BASE_DIR/mapper"
mkdir -p "$BASE_DIR/pojo"
mkdir -p "$BASE_DIR/service/impl"
mkdir -p "$BASE_DIR/util"
mkdir -p "$PROJECT_NAME/src/main/resources/static"
mkdir -p "$PROJECT_NAME/src/main/resources/templates"
mkdir -p "$TEST_DIR"
mkdir -p "$PROJECT_NAME/target"

echo "目录结构创建完成。"

# 创建 pom.xml
cat > "$PROJECT_NAME/pom.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
                             https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.4.0</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>org.jackasher.$PACKAGE_NAME</groupId>
    <artifactId>$PACKAGE_NAME</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>$PROJECT_NAME</name>
    <description>$PROJECT_NAME</description>
    <url/>
    <licenses>
        <license/>
    </licenses>
    <developers>
        <developer/>
    </developers>
    <scm>
        <connection/>
        <developerConnection/>
        <tag/>
        <url/>
    </scm>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>3.0.4</version>
        </dependency>

        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter-test</artifactId>
            <version>3.0.4</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
EOL

echo "pom.xml 创建完成。"

# 创建主应用类
cat > "$BASE_DIR/${CLASS_NAME}Application.java" <<EOL
package org.jackasher.$PACKAGE_NAME;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ${CLASS_NAME}Application {
    public static void main(String[] args) {
        SpringApplication.run(${CLASS_NAME}Application.class, args);
    }
}
EOL

echo "主应用类 ${CLASS_NAME}Application.java 创建完成。"

# 创建 RedPacketController.java
cat > "$BASE_DIR/controller/RedPacketController.java" <<EOL
package org.jackasher.$PACKAGE_NAME.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RedPacketController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello, Red Packet!";
    }
}
EOL

echo "RedPacketController.java 创建完成。"

# 创建 RedPacket.java
cat > "$BASE_DIR/pojo/RedPacket.java" <<EOL
package org.jackasher.$PACKAGE_NAME.pojo;

public class RedPacket {
    private Long id;
    private Double amount;

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
}
EOL

echo "RedPacket.java 创建完成。"

# 创建 RedPacketService.java
cat > "$BASE_DIR/service/RedPacketService.java" <<EOL
package org.jackasher.$PACKAGE_NAME.service;

public interface RedPacketService {
    // 定义服务方法
}
EOL

echo "RedPacketService.java 创建完成。"

# 创建 RedPacketServiceImpl.java
cat > "$BASE_DIR/service/impl/RedPacketServiceImpl.java" <<EOL
package org.jackasher.$PACKAGE_NAME.service.impl;

import org.jackasher.$PACKAGE_NAME.service.RedPacketService;
import org.springframework.stereotype.Service;

@Service
public class RedPacketServiceImpl implements RedPacketService {
    // 实现服务方法
}
EOL

echo "RedPacketServiceImpl.java 创建完成。"

# 创建 DBUtil.java
cat > "$BASE_DIR/util/DBUtil.java" <<EOL
package org.jackasher.$PACKAGE_NAME.util;

public class DBUtil {
    // 数据库工具类
}
EOL

echo "DBUtil.java 创建完成。"

# 创建 application.properties
cat > "$PROJECT_NAME/src/main/resources/application.properties" <<EOL
# Spring Boot 配置示例

# 服务器端口
server.port=8080

# 数据库配置
spring.datasource.url=jdbc:mysql://localhost:3306/red_envelope_db?useSSL=false&serverTimezone=UTC
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
EOL

echo "application.properties 创建完成。"

# 创建 index.html
cat > "$PROJECT_NAME/src/main/resources/static/index.html" <<EOL
<!DOCTYPE html>
<html>
<head>
    <title>抢红包模拟器</title>
</head>
<body>
    <h1>欢迎使用抢红包模拟器</h1>
    <p>此处添加前端内容。</p>
</body>
</html>
EOL

echo "index.html 创建完成。"

# 创建 EleApplicationTests.java
cat > "$TEST_DIR/${CLASS_NAME}ApplicationTests.java" <<EOL
package org.jackasher.$PACKAGE_NAME;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ${CLASS_NAME}ApplicationTests {

    @Test
    void contextLoads() {
    }

}
EOL

echo "${CLASS_NAME}ApplicationTests.java 创建完成。"

echo "所有文件创建完成。"


echo "项目 '$PROJECT_NAME' 构建完成。"
echo "进入项目目录并使用 Maven 构建项目："
echo "  cd $PROJECT_NAME"
echo "  mvn clean install"
