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

 Ubuntu系统下执行：
> wget -c http://soft.vpser.net/lnmp/lnmp1.1-full.tar.gz && tar zxf lnmp1.1-full.tar.gz && cd lnmp1.1-full && ./ubuntu.sh

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

## 4.1 mysql配置

## 4.2 php配置

## 4.3 nginx配置

# 5. ecstore商城linux环境部署
 - 1.安装服务器环境，我这边是直接安装lnmp  一键安装包

 - 2.项目考进wwwroot目录   解压 tar zxvf   xxxx.gz   解压文件

 - 3.执行：cd /root/lnmp1.1-full && ./vhost.sh
![Alt text](http://chuantu.biz/t2/9/1432966255x-1376440110.png)

修改配置虚拟域名 
> vi  /usr/local/nginx/conf/vhost/www.hepinmeidu.com.conf

代码如下：
## 
     server{
          listen 80;
          #listen [::]:80;
          server_name www.hepinmeidu.com;
          index index.html index.htm index.php default.html default.htm default.php;
          root  /home/wwwroot/www.hepinmeidu.com;
          include other.conf;
          #error_page   404   /404.html;
          location ~ [^/]\.php(/|$)
               {
                    # comment try_files $uri =404; to enable pathinfo
                    #try_files $uri =404;
                    fastcgi_pass  unix:/tmp/php-cgi.sock;
                    fastcgi_index index.php;
                    include fastcgi.conf;
                    include pathinfo.conf;
                 }
          location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
               {
                    expires      30d;
               }
          location ~ .*\.(js|css)?$
               {
                    expires      12h;
               }
         access_log  /home/wwwlogs/www.hepinmeidu.com.log  access;
         error_log   /home/wwwlogs/www.hepinmeidu.com.error.log ;}

- 4.
> vi /usr/local/php/etc/php.ini   

修改php.ini文件最后一行加上

##
    [Zend Optimizer]
    zend_extension=/usr/local/zend/ZendGuardLoader.so  （lnmp环境下自动生成.so文件）
    zend_loader.enable=1
    zend_loader.disable_licensing=0
    zend_loader.obfuscation_level_support=3
    zend_loader.license_path=/home/wwwroot/www.hepinmeidu.com/config/developer.zl

（当授权文件只有一个时直接写授权文件，多个时zend_loader.license_path指向一个目录，该目录下同时包含多个developer.zl文件，请避免developer.zl文件重名，developer.zl 文件在confing文件夹中）

- 5.重启服务
> service nginx restart
> 
> service php-fpm restart

到这里就应该能访问了：

以下是个人配置时候出现得一些问题：


一．都配置好了后，还是无法访问到项目路径（配置得虚拟域名没解析）


        1.没有解析可能是域名没有开通，即域名未指向IP，可在本地hosts中自己配置指向
        2．Php版本不对ecstore只适用于php5.3得版本，请检查php版本是否是5.3

- 6.数据库创建


> CREATE DATABASE `ecstore` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

创建数据库（数据库必须是utf8编码得，否则安装完成后访问首页会报代码得错）

- 7.对 data,config,public 目录赋 777
##     
    chmod -R 775 /wwwroot/www.hepinmeidu.com/data
    chmod -R 775 /wwwroot/www.hepinmeidu.com/config
    chmod -R 775 /wwwroot/www.hepinmeidu.com/public

二．在点击安装后无法链接数据库  如图

![Alt text](http://chuantu.biz/t2/9/1432968022x-1133352443.png)

1. 连不上数据库   查看pdo_mysql.default_socket=/tmp/mysql.sock是否有开启
2. 命令行mysql –uroot –pxxx(xxx指数据库密码) –h 127.0.0.1   是否能连上数据库，如果连不上命令行mysql –uroot –pxxx(xxx指数据库密码) –h localhost  是否能连上数据库    127.0.0.1连不上得话可能是防火墙禁止了  
查看iptables -L  防火墙状态  看mysql是否有被 DROP，·如果被DROP掉了执行
 
> iptables -D INPUT 1 

(“1”指的是DROP是第几条）

重启服务

> /etc/init.d/iptables restart

- 8.上述步骤走完，应该就能出来安装页面，在浏览器中输入www.hepinmeidu.com 开始安装
- 
![Alt text](http://chuantu.biz/t2/9/1432968341x-1133352443.png)

三. 在linux服务器安装LNMP环境之后，上传网站用vhost.sh 绑定域名之后，（服务器ip也解析好了），还是无法访问网站：

首先，要确定是不是真的解析好了，你Ping一下域名，看是否指向那个IP，如果是，表示解析成功了；
其次，要确定是否已经绑定好了域名，进/usr/local/nginx/conf/vhost/目录下看看是否有该域名的配置文件，且正确配置了；
如果以上都正确，还访问不到，就有可能被墙了或者防火墙限制了，尝试直接关闭防火墙 service iptables stop 
然后重启所有服务，再次访问看能否访问成功，能成功表示是被防火墙限制了，修改防火墙，保存重启。

根据以下命令，写可以访问的端口号
     
    /sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT (网站端口)
    /sbin/iptables -I INPUT -p tcp --dport 22 -j ACCEPT (SSH端口)
    /sbin/iptables -I INPUT -p tcp --dport 21 -j ACCEPT (FTP端口)

然后保存：

> /etc/rc.d/init.d/iptables save

重启

> /etc/init.d/iptables restart


# 6.FTP配置 
- 1.安装vsftpd组件

> yum -y install vsftpd    

- 2. 启动服务
> service vsftpd start  

- 3.匿名进入ftp
> ftp localhost   

进入输入用户名ftp，密码随便（因为默认是允许匿名的）
登录成功，就代表ftp服务可用了。
但是，外网是访问不了的，所以还要继续配置

- 4.取消匿名登陆

> vi /etc/vsftpd/vsftpd.conf 

> 把anonymous_enable=YES ，改为NO

- 5.重启服务
> service vsftpd restart 

- 6.新建一个用户(ftpuser为用户名，随便就可以)


> useradd ftpuser 

修改密码（输入两次）

> passwd ftpuser 

这样一个用户建完，可以用这个登录。登录后默认的路径为 /home/ftpuser.

- 7.开放21端口    ftp默认的端口为21，

- 8.ftp：//122.11.49.11外网是可以访问上去了，可是发现没法返回目录，也上传不了，因为selinux作怪了。修改selinux 

> getsebool -a | grep ftp 

执行上面命令，再返回的结果看到两行都是off，代表，没有开启外网的访问

> ....   
> allow_ftpd_full_access off   
> ....  
> ....  
> ftp_home_dir off 

只要把上面都变成on就行,执行  
   
> setsebool -P allow_ftpd_full_access 1 
   
> setsebool -P ftp_home_dir  1 

再重启一下vsftpd

> service vsftpd restart 


问题：
1.vsftod登陆报错 500 opps:could not open chroot() list file:/etc/vsftpd/chroot_list 

建立这个用户列表,不需要写内容就可以了
用命令“markdir /etc/vsftpd/chroot_list”，新建一个文件。

2.输入：getsebool -a | grep ftp 

出现：setenforce: SELinux is disabled

解决办法：

> vi /etc/selinux/config

更改为：SELINUX=1
必须重启linux，不重启是没办法立刻开启selinux的


#7. crontab  定时任务配置
- 1.安装cron

>  yum -y install  vixie-cron crontabs 

- 2.root权限下执行以下命令：crontab -u www -e将下面两句放在里面
##     
    * * * * * /home/wwwroot/www.hepinmeidu.com/script/queue/queue.sh /usr/bin/php >/dev/null
    
    * * * * * /home/wwwroot/www.hepinmeidu.com/script/crontab/crontab.php /usr/bin/php >/dev/null

- 3.在phpini中去掉 chroot,proc_open,proc_get_status

> disable_functions=passthru,exec,system,scandir,chgrp,chown,shell_exec,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassth

按照上面添加完crontab定时任务后发现，定时任务不能定时自动执行。但是手动执行一下/home/wwwroot/www.hepinmeidu.com/script/queue/queue.sh  这个脚本有用，那么请检查 每条crontab任务是否以空白行字符结尾，否则cron将认为计划（至少是部分的）被broken并拒绝建立该任务。


