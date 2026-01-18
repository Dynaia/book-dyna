## 登录认证

> 基于 Spring Security 做认证。

- 基于动态策略模式自动选择认证方式，默认实现密码登录策略。

- 登录生成 accessToken 和 refreshToken，已实现基于 Redis 的双跳模型保存/刷新用户会话、踢人、顶号等功能。

- 登录成功后自动缓存用户信息及用户权限。

```pom
<dependency>
    <groupId>com.dynaframework</groupId>
    <artifactId>dyna-auth</artifactId>
</dependency>
```

## 配置项

全部可配置项见 AuthProperties 配置类。

## 扩展点

- 必须实现 LoginUserDetailsProvider 根据账号查找用户。

- 可选实现 LoginAuthenticationProvider 实现指定登录方式。

---

{docsify-updated}