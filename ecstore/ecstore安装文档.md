# 1. 系统要求
系统最好别开其他服务，尤其是nginx,apache服务。在开着其他服务的情况下必须保证我们在配置nginx的时候不影响nginx服务

- 因为在跟一些客户安装ecstore的时候，因为以前服务器上本身有着其他服务（apache服务，tomcat服务），导致配置nginx的时候，nginx服务启动一直有问题

# 2. 环境要求
- mysql 必须是5.5版本的（是必须不能高也不能低）
- php 必须是5.3版本的（是必须不能高也不能低）
- nginx 最好1.6以上

# 3. 集成安装环境
这边统一安装lnmp集成环境 [http://lnmp.org/install.html](http://lnmp.org/install.html "lnmp一键安装")

**安装步骤** 

 - 1、使用putty或类似的SSH工具远程登陆服务器；
 - 2、下载并安装LNMP一键安装包：
 
 CentOS系统下执行：
> wget -c http://soft.vpser.net/lnmp/lnmp1.1-full.tar.gz && tar zxf lnmp1.1-full.tar.gz && cd lnmp1.1-full && ./centos.sh

 Debian系统下执行：
> wget -c http://soft.vpser.net/lnmp/lnmp1.1-full.tar.gz && tar zxf lnmp1.1-full.tar.gz && cd lnmp1.1-full && ./debian.sh


按上述命令执行后，会出现如下提示：

![Alt text](http://chuantu.biz/t2/9/1432953411x-1133352443.png)

这一步需要设置MySQL的root密码，输入后回车进入下一步，如下图所示：

![Alt text](http://chuantu.biz/t2/9/1432953592x-1133352443.png)

这里需要确认是否启用MySQL InnoDB，如果不确定是否启用可以输入 y ，这个可以单独在MySQL文件里关闭，输入 y 表示启用，输入 n 表示不启用。输入 y 或 n 后回车进入下一步，显示如下信息：

![Alt text](http://chuantu.biz/t2/9/1432953659x-1133352443.png)

这一步是选择php版本，可以选择 PHP 5.3.28 或 PHP 5.2.17，如果需要安装PHP 5.3.28的话输入 y ，如果需要安装PHP 5.2.17 输入 n，输入 y 或 n 后回车，(这边必须选y,PHP必须是5.3版本）进入下一步MySQL版本的选择，如下图：

![Alt text](http://chuantu.biz/t2/9/1432964519x-1133352443.png)

可以选择MySQL 版本 5.1.73、5.5.37或MariaDB 5.5.37，如果需要安装MySQL 5.5.37的话输入 y ，如果需要安装MySQL 5.1.73 输入n，如果需要安装MariaDB 5.5.37的话输入 md，输入完成后回车，完成选择。

提示"Press any key to start..."，按回车键确认开始安装。
LNMP脚本就会自动安装编译Nginx、MySQL、PHP、phpMyAdmin、Zend Optimizer这几个软件。

安装时间可能会几十分钟到几个小时不等，主要是机器的配置网速等原因会造成影响。

 - 3、安装完成
如果显示如下界面：

![Alt text](http://chuantu.biz/t2/9/1432964636x-1133352443.png)

# 4. 自己搭建环境

# 5. 配置

## 5.1 mysql配置

## 5.2 php配置

## 5.3 nginx配置

# 异常处理
