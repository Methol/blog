---
title: "IntelliJ IDEA实用技巧"
date: 2018-02-05 14:10:55
tags: [IntelliJ IDEA]
---


## IDEA的一些细节设置

1. 代码提示模式是区分大小写的

   - IntelliJ IDEA 的代码提示和补充功能有一个特性：区分大小写。默认 `First letter` 是区分大小写的。
   - 区分大小写的情况是这样的：比如我们在 Java 代码文件中输入 `stringBuffer` IntelliJ IDEA 是不会帮我们提示或是代码补充的，但是如果我们输入 `StringBuffer` 就可以进行代码提示和补充。
   - 如果想不区分大小写的话，改为 `None` 选项即可（***建议改成这个***）。

   ![](https://i.loli.net/2018/02/04/5a7710503fd04.png)

2. IDEA默认不开启自动import package

   根据图中的提示自己配置。

   ![](https://i.loli.net/2018/02/04/5a7711a712bd3.png)

3. 禁用或卸载一些用不到的插件

   IDEA是Jetbrains全家桶系列功能最强大的一个，有很多用不到的插件可以禁用了，提升速度。

4. 开启内存显示

   IDEA也是Java写的，点击这个内存按钮可以好像可以手动GC一次，小内存用户的福音。

   设置位置：Setting -> Appearance & Behavior -> Appearance -> Show memory indicator

   ![](https://i.loli.net/2018/02/04/5a7717436b36c.png)

![](https://i.loli.net/2018/02/04/5a7717a7ed46f.png)

## IDEA自身功能

### Live Template

实时代码模板

超级强大的功能，请发挥你的想象力！

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/live-template.mp4" type="video/mp4"></video>

### Custom Postfix Templates

插件地址：https://plugins.jetbrains.com/plugin/9862-custom-postfix-templates

个人认为是比上面一个更强大的功能，有很多人提了issue，希望官方支持这个功能。最后是有人做了一个插件，支持了该功能。详情参考下面这个issue。

https://youtrack.jetbrains.com/issue/IDEA-122443#comment=27-2343352

Custom Postfix Templates 和官方自带的Postfix Completion功能是一样的，不过自带的 Postfix Completion没有自定义的功能，不能编写自己的模板。

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/custom-postfix.mp4" type="video/mp4"></video>

### 自动生成UML图

1. maven依赖关系图，方便排查错误的依赖关系。

   <video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/maven-uml.mp4" type="video/mp4"></video>

2. Java UML类图，阅读代码、了解代码结构、写文档的好工具。

   <video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/class-uml.mp4" type="video/mp4"></video>

### Language Injection

快捷键 `alt enter`

编辑双引号中的JSON和正则表达式编辑，不用写双斜线。

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/Language-Injection.mp4" type="video/mp4"></video>

### Smart Step Into

快捷键 `shift f7`

Debug的时候，一行多个方法调用，可以自己选择进入某个方法。

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/Smart-Step-Into.mp4" type="video/mp4"></video>


### DataBase Tool

使用IDEA管理数据库，可以方便的查询，写sql等。

标记为全局数据库，可以打开任何一个项目都能看到改数据库。

![](https://i.loli.net/2018/02/04/5a7704de265db.png)

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/database-tools.mp4" type="video/mp4"></video>

## 插件篇

### IDE Features Trainer

https://plugins.jetbrains.com/plugin/8554-ide-features-trainer

新手使用，官方出品的让你快速了解IDEA的强大功能。

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/IDE-Features-Trainer.mp4" type="video/mp4"></video>

### key promoter

https://plugins.jetbrains.com/plugin/4455-key-promoter

新手使用，提示你快速记忆快捷键。所有可以用快捷键的地方，只要用鼠标点击的就会有提示。

![](https://i.loli.net/2018/02/04/5a76f996314f4.png)

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/key-promoter.mp4" type="video/mp4"></video>

### Alibaba Java Coding Guidelines

插件地址：https://plugins.jetbrains.com/plugin/10046-alibaba-java-coding-guidelines

根据之前alibaba公开的《Java代码规范》做的插件，检查代码是否符合规约。

<video controls="controls" preload="none" width='100%' height='100%' src="http://static.tuzhihao.com/idea/alicheck.mp4" type="video/mp4"></video>

### Camel Case

插件地址：https://plugins.jetbrains.com/plugin/7160-camelcase

Switch easily between CamelCase, camelCase, snake_case and SNAKE_CASE. See Edit menu or use SHIFT + ALT + U.

IDE自带的只能大写转小写或者小写转大写。

![](https://i.loli.net/2018/02/04/5a7709a0d295d.png)

### 翻译插件(Translation)

插件地址：https://plugins.jetbrains.com/plugin/8579-translation

通过有道或者Google Translate插件翻译单词和句子，界面好看，还有发音。

![](https://i.loli.net/2018/02/04/5a76f6d15a4fa.png)

![](https://i.loli.net/2018/02/04/5a76f6b6527a8.png)

配置页面：

![](https://i.loli.net/2018/02/04/5a7706342dca9.png)

### Grep Console

插件地址：https://plugins.jetbrains.com/plugin/7125-grep-console

自己给error、warn、info的日志配色

有一个不好的地方，就是日志过多的时候会卡(可能是我电脑不好...)

![](https://i.loli.net/2018/02/04/5a7705e9677ef.png)

自定义配色：

![](https://i.loli.net/2018/02/04/5a7706016d595.png)

### Save Action

插件地址：https://plugins.jetbrains.com/plugin/7642-save-actions

主要功能：

1. 自动格式化代码和组织导入，不用手动快捷键了。
2. 可以设置只有改动的文件才会自动启用此插件（需要git或者其他vcs支持）
3. 自动添加忘了的`@Override`注解，自动给代码块添加`{}`

![](https://i.loli.net/2018/02/04/5a7707868de40.png)

### POJO to JSON

插件地址：https://plugins.jetbrains.com/plugin/9686-pojo-to-json

选中类-右键-MakeJson 将简单Java类型转成JSON

### GsonFormat

插件地址：https://plugins.jetbrains.com/plugin/7654-gsonformat

将json string 转为Class

## 破解

这软件实在太贵了。。。

源码来自一个IDEA交流群的jsp文件，改成了Spring boot方便启动和部署。

这段代码从idea14开始用到现在还是可用。

`App.java`

```java
package com.jetbrains.license.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;


@SpringBootApplication
@Controller
public class App {
    private static Logger LOG = LoggerFactory.getLogger(App.class);

    @SuppressWarnings("SpellCheckingInspection")
    private static final String PRIVATE_KEY_MODULES_HEX =
            "0b79cab7070008e18259c2127eb279c3163de51770cca8d3e8ad5eb2e592970a208caa3f0e78e9b19386195bd69a57d72497fce500e2349a9077a434fe5e58f6b";

    @SuppressWarnings("SpellCheckingInspection")
    private static final String PRIVATE_KEY_EXPONENT_HEX =
            "05bafda543d39a9bb191ccbd9b92d806b916934d8f404395fdfc84eb64843cf3fe19186fe10160b2ef95d860b03d0ebd1372f32873ec48da52a2c20748ee20de1";

    public static void main(String[] args) throws Exception {
        SpringApplication.run(App.class, args);
    }

    @RequestMapping("/*")
    @ResponseBody
    public String home(HttpServletRequest request) {
        LOG.info(request.getRequestURI());
        return "Hello World!";
    }

    @RequestMapping("/rpc/obtainTicket.action")
    @ResponseBody
    public String obtainTicket(HttpServletRequest request) {

        java.util.Map<String, String> data = new java.util.HashMap<>();

        data.put("build_date",           /* */ request.getParameter("buildDate"));
        data.put("client_version",       /* */ request.getParameter("clientVersion"));
        data.put("host_name",            /* */ request.getParameter("hostName"));
        data.put("machine_id",           /* */ request.getParameter("machineId"));
        data.put("product_code",         /* */ request.getParameter("productCode"));
        data.put("product_family_id",    /* */ request.getParameter("productFamilyId"));
        data.put("salt",                 /* */ request.getParameter("salt"));
        data.put("secure",               /* */ request.getParameter("secure"));
        data.put("username",             /* */ request.getParameter("userName"));
        data.put("version",              /* */ request.getParameter("version"));
        data.put("version_number",       /* */ request.getParameter("versionNumber"));

        int prolongation_period = 607875500;

        String xmlResponse = ""
                + "<ObtainTicketResponse><message></message><prolongationPeriod>"
                + (prolongation_period)
                + "</prolongationPeriod><responseCode>OK</responseCode><salt>"
                + data.get("salt")
                + "</salt><ticketId>1</ticketId><ticketProperties>licensee="
                + data.get("username")
                + "\tlicenseType=0\t"
                + "</ticketProperties></ObtainTicketResponse>"
                + "";

        StringBuilder sb = new StringBuilder();
        sb.append("<!-- ");
        try {
            sb.append(javax.xml.bind.DatatypeConverter.printHexBinary(licenseSignerSign(xmlResponse)));
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
        sb.append(" -->\n");
        LOG.info(sb.toString());
        return sb.toString() + xmlResponse;
    }

    /**
     * Signs the message with MD5 with RSA.
     *
     * @param message Text message to sign
     * @return Hex string of message signature
     */
    private static byte[] licenseSignerSign(String message) throws ServletException, java.io.IOException {
        java.security.Signature signer;
        try {
            java.security.KeyFactory kf = java.security.KeyFactory.getInstance("RSA");
            java.security.PrivateKey privateKey =
                    kf.generatePrivate(new java.security.spec.RSAPrivateKeySpec(
                            new java.math.BigInteger(PRIVATE_KEY_MODULES_HEX, 16),
                            new java.math.BigInteger(PRIVATE_KEY_EXPONENT_HEX, 16)));

            signer = java.security.Signature.getInstance("MD5withRSA");
            signer.initSign(privateKey);
            signer.update(message.getBytes("UTF-8"));

            return signer.sign();
        } catch (java.security.GeneralSecurityException e) {
            throw new ServletException(e);
        }
    }
}

```

`pom.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.tuzhihao.jetbrains</groupId>
    <artifactId>jetbrains-license-server</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>1.8</java.version>
    </properties>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.5.9.RELEASE</version>
    </parent>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
```

启动后，`License server` 输入`http://localhost:8080`

![](https://i.loli.net/2018/02/04/5a7719682e64d.png)

也可输入以下地址，我自己搭建的

https://s.tuzhihao.com:666





## 强烈推荐的IDEA教程

https://github.com/judasn/IntelliJ-IDEA-Tutorial

https://www.youtube.com/user/intellijideavideo/featured

