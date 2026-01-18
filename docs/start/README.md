## 获取项目

直接 Clone dyna-boot 示例项目 https://github.com/Dynaia/dyna-boot ，你便获得了一个完整的后台管理系统。

该系统可以直接作为单体项目进行二次开发，也可以作为用户认证微服务使用。

环境要求： **JDK21** **Maven** **Redis**

---

想从项目初始化开始？继续往下看。

## 从头开始

1. 基于 Maven 新建一个空白的 spring boot 项目

2. 设置 parent 依赖

```pom
<parent>
    <groupId>com.dynaframework</groupId>
    <artifactId>dyna-bom</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>
```

3. 引入核心依赖

```pom
<!-- 引入全部核心能力 -->
<dependency>
    <groupId>com.dynaframework.boot</groupId>
    <artifactId>dyna-boot-starter</artifactId>
</dependency>

<!-- 生成代码需要引入 -->
<dependency>
    <groupId>com.dynaframework</groupId>
    <artifactId>dyna-generator</artifactId>
    <scope>provided</scope>
</dependency>

<!-- 作为认证服务需要引入 -->
<dependency>
   <groupId>com.dynaframework</groupId>
   <artifactId>dyna-auth</artifactId>
</dependency>

<!-- 配置数据库驱动比如 Mysql -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>

```

4. 配置环境及编码

```pom
 <properties>
     <java.version>21</java.version>
     <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
     <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
 </properties>
```

5. 配置编译和打包插件

```pom
<build>
  <plugins>
      <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-compiler-plugin</artifactId>
          <configuration>
              <source>21</source>
              <target>21</target>
              <encoding>UTF-8</encoding>
              <annotationProcessorPaths>
                  <path>
                      <groupId>org.projectlombok</groupId>
                      <artifactId>lombok</artifactId>
                  </path>
                  <path>
                      <groupId>org.mapstruct</groupId>
                      <artifactId>mapstruct-processor</artifactId>
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
```

6. 项目基础配置

```properties
spring.application.name=dyna-boot
spring.servlet.multipart.max-file-size=10MB
# mysql
spring.datasource.url=jdbc:mysql://localhost:3306/dyna_boot?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=123456
# 最小空闲连接
spring.datasource.hikari.minimum-idle=1
# 最大连接数 CPU核心数2倍到3倍
spring.datasource.hikari.maximum-pool-size=6
# 空闲连接回收 正常10分钟
spring.datasource.hikari.idle-timeout=600000
# 连接最大存活 需小于数据库wait_timeout 默认30分钟
spring.datasource.hikari.max-lifetime=1800000
# 获取连接超时 不超过30秒
spring.datasource.hikari.connection-timeout=30000
# redis
spring.data.redis.host=localhost
spring.data.redis.port=6379
spring.data.redis.database=0
spring.data.redis.password=
# 读取超时时间 不超过3秒
spring.data.redis.timeout=2s
# 最大连接数 CPU核心数2倍
spring.data.redis.lettuce.pool.max-active=8
# 最大空闲连接
spring.data.redis.lettuce.pool.max-idle=8
# 最小空闲连接
spring.data.redis.lettuce.pool.min-idle=2
# 获取连接超时
spring.data.redis.lettuce.pool.max-wait=1s
# dyna
# 认证白名单接口
dyna.security.authWhitelist=/auth/login,/auth/refresh
# 登录认证密钥
dyna.auth.secret=7tumfaggAnxuc9x4Kqln6IuzZbpmmU0ovH9m879NeTw=
```

7. 启动类添加 MapperScan 扫描，启动项目，按提示缺啥补啥（可能需要提供一些 SPI 实现）

```java

@MapperScan("com.dyna.boot.**.repository")
@SpringBootApplication
public class DynaBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(DynaBootApplication.class, args);
    }
}
```

---

## 核心扩展

1. 默认单体项目模式 `dyna.security.mode=boot`，如果作为微服务项目，需要配置 `dyna.security.mode=cloud`

2. 微服务模式需要配置上下文密钥比如 `dyna.security.identitySecret=gnd2Be+WHM3JvaRdG42A6KuEsdDpWN1erDbMcj/2Bhk=`

3. 开启 DEBUG 日志：`logging.level.com.dynaframework=debug`

4. 配置国际化：resources 目录下新建 message.properties 等文件

---
{docsify-updated}