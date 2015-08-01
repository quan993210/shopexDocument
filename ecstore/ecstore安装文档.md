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

# 4. 单独搭建环境


- 以下安装过程中可能存在部分下载链接错误导致下载失败，请自行下载对应的安装包


标准库安装————标准库是一些基本的底层库，有很多软件都是依附与这些底层库
    
    yum -y install wget make vim install gcc gcc-c++ ncurses ncurses-devel autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers pcre pcre-devel  zlip zlip-devel



php依赖库安装

libxml2 ———— 包含库和实用工具用于解析XML文件

    wget http://xmlsoft.org/sources/libxml2-2.9.0.tar.gz
    tar zxvf libxml2-2.9.0.tar.gz
    cd libxml2-2.9.0
    ./configure
    make&&make install
    
    libmcrypt ———— 加密算法扩展库(支持DES, 3DES, RIJNDAEL, Twofish, IDEA, GOST, CAST-256, ARCFOUR, SERPENT, SAFER+等算法)
    
    wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz
    tar zxvf libmcrypt-2.5.7.tar.gz
    cd libmcrypt-2.5.7
    ./configure
    make && make install
    


###MYSQL配置&安装

 **安装** 

    wget http://soft.vpser.net/datebase/mysql/mysql-5.5.37.tar.gz
    tar zxvfmysql-5.5.37.tar.gz -C /usr/local/webserver
    mv mysql-5.5.37.tar.gz mysql
 **配置**

    shell> groupadd mysql
    shell> useradd -r -g mysql mysql
    shell> cd /usr/local/webserver/mysql
    shell> chown -R mysql .
    shell> chgrp -R mysql .
    shell> scripts/mysql_install_db --user=mysql
    shell> chown -R root .
    shell> chown -R mysql data
    # Next command is optional
    shell> cp support-files/my-default.cnf /etc/my.cnf
    shell> bin/mysqld_safe --user=mysql &
**修改mysql.server脚本**

    将
    basedir=
    datadir=
    改为
    basedir=/usr/local/webserver/mysql
    datadir=/usr/local/webserver/mysql/data

**配置启动脚本**

    cd /usr/local/webserver/mysql
    cp support-files/mysql.server /etc/init.d/mysql

**启动mysql**

    service mysql start
    service mysql stop
    service mysql restart
###NGINX 安装&配置

**安装**

    wget http://nginx.org/download/nginx-1.5.1.tar.gz
    tar zxvf nginx-1.5.1.tar.gz
    cd nginx-1.5.1
    ./configure --prefix=/usr/local/webserver/nginx
    make && make install

**参数配置**

 fastcgi创建php-cgi.conf

    cat > /usr/local/webserver/nginx/conf/php_fcgi.conf <<'EOF'
    fastcgi_pass  unix:/tmp/php_fcgi.sock;
    
    fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
    fastcgi_param  SERVER_SOFTWAREnginx;
    
    fastcgi_param  QUERY_STRING   $query_string;
    fastcgi_param  REQUEST_METHOD $request_method;
    fastcgi_param  CONTENT_TYPE   $content_type;
    fastcgi_param  CONTENT_LENGTH $content_length;
    
    fastcgi_param  SCRIPT_FILENAME$document_root$fastcgi_script_name;
    fastcgi_param  SCRIPT_NAME$fastcgi_script_name;
    fastcgi_param  REQUEST_URI$request_uri;
    fastcgi_param  DOCUMENT_URI   $document_uri;
    fastcgi_param  DOCUMENT_ROOT  $document_root;
    fastcgi_param  SERVER_PROTOCOL$server_protocol;
    
    fastcgi_param  REMOTE_ADDR$remote_addr;
    fastcgi_param  REMOTE_PORT$remote_port;
    fastcgi_param  SERVER_ADDR$server_addr;
    fastcgi_param  SERVER_PORT$server_port;
    fastcgi_param  SERVER_NAME$server_name;

pathinfo
创建pathinfo.conf

    cat > /usr/local/webserver/nginx/conf/pathinfo.conf << 'EOF'
    set $real_script_name $fastcgi_script_name;
    if ($fastcgi_script_name ~ "(.+?\.php)(/.*)") {
    set $real_script_name $1;
    set $path_info $2;
    }
    fastcgi_param SCRIPT_FILENAME $document_root$real_script_name;
    fastcgi_param SCRIPT_NAME $real_script_name;
    fastcgi_param PATH_INFO $path_info;
    EOF
    
平滑重启方法

    /usr/local/webserver/nginx/sbin/nginx -s reload

nginx.conf
创建nginx.conf

    cat > /usr/local/webserver/nginx/conf/nginx.conf <<'EOF'
    user  www www;
    worker_processes 4;
    error_log  /var/log/nginx_error.log  crit;
    worker_rlimit_nofile 65535;
    events
    {
      use epoll;
      worker_connections 65535;
    }
    
    http
    {
      include   mime.types;
      default_type  application/octet-stream;
    
      server_names_hash_bucket_size 128;
      client_header_buffer_size 32k;
      large_client_header_buffers 4 32k;
      client_max_body_size 8m;
    
      sendfile on;
      tcp_nopush on;
      keepalive_timeout 60;
      tcp_nodelay on;
    
      fastcgi_connect_timeout 300;
      fastcgi_send_timeout 300;
      fastcgi_read_timeout 300;
      fastcgi_buffer_size 64k;
      fastcgi_buffers 4 64k;
      fastcgi_busy_buffers_size 128k;
      fastcgi_temp_file_write_size 128k;
    
      gzipon;
      gzip_min_length   1k;
      gzip_buffers   4 8k;
      gzip_http_version  1.1;
      gzip_types   text/plain application/x-javascript text/css  application/xml;
      gzip_disable "MSIE [1-6]\.";
    
      log_format  access  '$remote_addr - $remote_user [$time_local] "$request" '
     '$status $body_bytes_sent "$http_referer" '
     '"$http_user_agent" $http_x_forwarded_for';
    
      include site/*.conf;
    }
    EOF

建立站点目录
创建目录

    mkdir -pv /data/www
    chmod -R 777 /data/www
    chown -R www:www /data/www
    
    mkdir -pv /usr/local/webserver/nginx/conf/site
    chmod -R 777 /usr/local/webserver/nginx/conf/site

创建默认站点配置文件default.conf

    cat > /usr/local/webserver/nginx/conf/site/default.conf <<'EOF'
    server
    {
    listen   80;
    server_name  default;
    index index.html index.htm index.php;
    root  /data/www;
    
    
    location / {
    if (!-e $request_filename) {
    rewrite ^/(.*)$ /index.php/$1 last;
    }
    }
    
    
    location ~ .*\.php[/]?
    {
      include php_fcgi.conf;
       include pathinfo.conf;
    }
    
    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
    {
      expires  30d;
    }
    
    location ~ .*\.(js|css)?$
    {
      expires  1h;
    }
    
    access_log /var/log/nginx_access.log;
    
    }
    EOF
重启nginx


    /usr/local/webserver/nginx/sbin/nginx -s reload
启动|停止|重启 脚本

    #!/bin/sh
    #
    # nginx - this script starts and stops the nginx daemin
    #
    # chkconfig:   - 85 15
    # description:  Nginx is an HTTP(S) server, HTTP(S) reverse \
    #   proxy and IMAP/POP3 proxy server
    # processname: nginx
    # config:  /usr/local/webserver/nginx/conf/nginx.conf
    # pidfile: /usr/local/webserver/nginx/logs/nginx.pid
    
    # Source function library.
    . /etc/rc.d/init.d/functions
    
    # Source networking configuration.
    . /etc/sysconfig/network
    
    # Check that networking is up.
    [ "$NETWORKING" = "no" ] && exit 0
    
    nginx="/usr/local/webserver/nginx/sbin/nginx"
    prog=$(basename $nginx)
    
    NGINX_CONF_FILE="/usr/local/webserver/nginx/conf/nginx.conf"
    
    lockfile=/var/lock/subsys/nginx
    
    start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6
    echo -n $"Starting $prog: "
    daemon $nginx -c $NGINX_CONF_FILE
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
    }
    
    stop() {
    echo -n $"Stopping $prog: "
    killproc $prog -QUIT
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
    }
    
    restart() {
    configtest || return $?
    stop
    start
    }
    
    reload() {
    configtest || return $?
    echo -n $"Reloading $prog: "
    killproc $nginx -HUP
    RETVAL=$?
    echo
    }
    
    force_reload() {
    restart
    }
    
    configtest() {
      $nginx -t -c $NGINX_CONF_FILE
    }
    
    rh_status() {
    status $prog
    }
    
    rh_status_q() {
    rh_status >/dev/null 2>&1
    }
    
    case "$1" in
    start)
    rh_status_q && exit 0
    $1
    ;;
    stop)
    rh_status_q || exit 0
    $1
    ;;
    restart|configtest)
    $1
    ;;
    reload)
    rh_status_q || exit 7
    $1
    ;;
    force-reload)
    force_reload
    ;;
    status)
    rh_status
    ;;
    condrestart|try-restart)
    rh_status_q || exit 0
    ;;
    *)
    echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
    exit 2
    esac
 设置开机启动
    
    chkconfig --add nginx
    chkconfig nginx on
   测试
    
    cat > /data/www/index.php <<'EOF'
    <?php
    echo 'Welcome to yiyon'
    EOF
 使用curl查看


    [root@ecos02 ~]# curl 182.92.212.163

结果应该返回

    Welcome to yiyon!
   
###PHP 安装&配置

**安装**

- 安装编译PHP需要的支持库

安装freetype库
    
    tar zxvf freetype-2.3.5.tar.gz
    cd freetype
    ./configure --prefix=/usr/local/webserver/freetype/
    make && make install
    
编译安装前的准备
提示：默认的php安装后gd不支持jpg，只支持gif、png、bmp。所以首先要安装gd库
    
    wget http://www.boutell.com/gd/http/gd-2.0.35.tar.gz
    tar zxvf gd-2.0.33.tar.gz
    cd gd-2.0.33
    ./configure --prefix=/usr/local/webserver/gd2/
    make && make install
libiconv
加强系统对支持字符编码转换的功能

    wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.1.tar.gz
    tar zxvf libiconv-1.13.1.tar.gz
    cd libiconv-1.13.1/
    ./configure --prefix=/usr/local
    make
    make install
    
    libmcrypt

加密算法库，PHP扩展mcrypt功能对此库有依耐关系

    wget http://downloads.sourceforge.net/mcrypt/libmcrypt-2.5.8.tar.gz
    tar zxvf libmcrypt-2.5.8.tar.gz
    cd libmcrypt-2.5.8
    ./configure
    make
    make install
    /sbin/ldconfig
    
    cd libltdl/
    ./configure --enable-ltdl-install
    make
    make install
    
    mhash
    
hash 加密算法库

    wget http://downloads.sourceforge.net/mhash/mhash-0.9.9.9.tar.gz
    tar zxvf mhash-0.9.9.9.tar.gz
    cd mhash-0.9.9.9
    ./configure
    make
    make install
建立软连接
    
    ln -s /usr/local/lib/libiconv.so.2 /usr/lib/libiconv.so.2
    
    ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
    ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
    ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
    ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
    ln -s /usr/local/bin/libmcrypt-config /usr/bin/libmcrypt-config
    
    ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
    ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
    ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
    ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
    ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1

配置立即生效

    ldconfig

mcrypt

    wget http://downloads.sourceforge.net/mcrypt/mcrypt-2.6.8.tar.gz
    tar zxvf mcrypt-2.6.8.tar.gz
    cd mcrypt-2.6.8/
    /sbin/ldconfig
    ./configure
    make
    make install
开始编译

    wget  http://us2.php.net/distributions/php-5.3.29.tar.gz    
    tar zxvf php-5.3.29.tar.gz
    cd php-5.3.29
    ./configure --prefix=/usr/local/webserver/php --enable-fpm --with-mysql=/usr/local/webserver/mysql \
    --with-mysqli=/usr/local/webserver/mysql/bin/mysql_config --with-config-file-path=/usr/local/webserver/php  \
    --with-openssl --enable-mbstring --with-zlib --enable-xml --with-freetype-dir=/usr/local/webserver/freetype/ --with-gd=/usr/local/webserver/gd2/ --with-jpeg-dir  \
    --enable-bcmath --with-mcrypt --with-iconv --enable-pcntl --enable-shmop --enable-simplexml --enable-ftp
    make && make install
    
    cp php.ini-development /usr/local/webserver/php/php.ini

修改php(php.ini)

      将  ;date.timezone =
      改为 date.timezone = prc

php+pathinfo（php.ini）

    enable_dl = On
    cgi.force_redirect = 0
    cgi.fix_pathinfo=1
    fastcgi.impersonate = 1
    cgi.rfc2616_headers = 1
    allow_url_fopen = On


创建www用户和组

    /usr/sbin/groupadd www
    /usr/sbin/useradd -g www www
    
编辑php-fpm.conf

    cat > /usr/local/webserver/php/etc/php-fpm.conf <<'EOF'
    [global]
    pid = /usr/local/webserver/php/var/run/php-fpm.pid
    error_log = /usr/local/webserver/php/var/log/php-fpm.log
    log_level = notice
    emergency_restart_threshold = 10
    emergency_restart_interval = 1m
    process_control_timeout = 5s
    daemonize = yes
    
    [www]
    listen = /tmp/php_fcgi.sock
    listen.backlog = -1
    listen.allowed_clients = 127.0.0.1
    user = www
    group = www
    listen.mode=0666
    pm = static
    pm.max_children = 64
    pm.start_servers = 20
    pm.min_spare_servers = 5
    pm.max_spare_servers = 35
    pm.max_requests = 1024
    
    request_terminate_timeout = 0s
    request_slowlog_timeout = 0s
    slowlog = logs/slow.log
    rlimit_files = 65535
    rlimit_core = 0
    chroot =
    chdir =
    catch_workers_output = yes
    env[HOSTNAME] = $HOSTNAME
    env[PATH] = /usr/local/bin:/usr/bin:/bin
    env[TMP] = /tmp
    env[TMPDIR] = /tmp
    env[TEMP] = /tmp
    
    php_flag[display_errors] = off
    EOF

启动前可先测试下php-fpm.conf的语法是否正确。

    /usr/local/webserver/php/sbin/php-fpm -t

如出现下面的提示，表示没有问题。

    [30 18:47:32] NOTICE: configuration file /usr/local/webserver/php/etc/php-fpm.conf test is successful
    
启动php-cgi进程后，监听的是127.0.0.1的9000端口，进程数为64(如果服务器内存小于3GB，可以只开启64个进程)，用户为www。

    #/usr/local/webserver/php/sbin/php-fpm

设置开机启动

    chkconfig -add php-fpm
    chkconfig php-fpm on

启动 php-fpm

    service php-fpm start

检查phpinfo php+nginx是否配置成功

解密工具

下载

    ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz

安装

      tar zxvf ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
      cd ZendGuardLoader-php-5.3-linux-glibc23-x86_64/
      cp php-5.3.x/ZendGuardLoader.so /usr/local/webserver/php/ext/

配置
打开php.ini，加入以下代码：
    
    [Zend Guard]
    ;/usr/local/webserver/php/ext/ZendGuardLoader.so  这个是你当时指定的zend的目录
    zend_extension=/usr/local/webserver/php/ext/ZendGuardLoader.so
    zend_loader.enable=1
    zend_loader.disable_licensing=0
    zend_loader.obfuscation_level_support=3
    zend_loader.license_path=
    
重启nginx 和 php-fpm，打开phpinfo查看如下图所示，证明配置成功：

![Alt text](http://chuantu.biz/t2/11/1438442142x-1566638291.png)


- 安装走到这里就配置环境就基本上安装完成了。在安装过程中可能出现许多未知的问题，以下是个人在配置环境中遇到的一些问题以及解决的办法，仅供参开。

**php5.3.29安装问题**

1.configure: error: Cannot find ldap libraries in /usr/lib.

解决办法:

    cp -frp /usr/lib64/libldap* /usr/lib/
    然后再./configure ...即可


2./root/php-5.3.29/sapi/cli/php: error while loading shared libraries: libmysqlclient.so.18: cannot open shared object file: No such file or directory

解决办法：

    find / -name libmysqlclient.so.18
    find / -name libmysqlclient.so
    ln -s /usr/local/webserver/mysql/lib/libmysqlclient.so.18 /usr/lib/
    ln -s /usr/local/webserver/mysql/lib/libmysqlclient.so /usr/lib/
    
3.chmod: cannot access `ext/phar/phar.phar': No such file or directory
make: [ext/phar/phar.phar] Error 1 (ignored)

解决办法：

    cp /root/php-5.3.29/ext/phar/phar.php  /root/php-5.3.29/ext/phar/phar.phar


4. configure error xml2-config not found. please check your libxml2 installation

解决办法：

    重新安装libxml2和libxml2-devel包, yum安装的时候发现新版本会提示更新，需要更新的可以更新，不要跳过就行了。
    [root@rh-linux /]# yum install libxml2
    [root@rh-linux /]# yum install libxml2-devel -y
    安装完之后查找xml2-config文件是否存在
    [root@rh-linux /] # find / -name "xml2-config"
    /usr/bin/xml2-config 
    如果存在的话重新安装php
    [root@rh-linux  php-5.4.3]# ./configure
    
5.configure: error: Cannot find OpenSSL's <evp.h>


    解决办法： yum  install  openssl.x86_64 openssl-devel.x86_64 -y

6.configure: error: Please reinstall the libcurl distribution -easy.h should be in <curl-dir>/include/curl/

    解决办法：
     yum install curl curl-devel 

7.configure: error: jpeglib.h not found.

    解决办法：
    yum install libjpeg-devel

8.configure: error: Cannot find ldap.h

    解决办法：
     yum install openldap
    yum install openldap-devel

9.configure: error: mcrypt.h not found. Please reinstall libmcrypt.

    解决办法：
    1、安装第三方yum源   （如果有直接走第二步）
    wget http://www.atomicorp.com/installers/atomic
    sh ./atomic
    2、使用yum命令安装
    yum  install  php-mcrypt  libmcrypt  libmcrypt-devel 

10.Configure: error: Cannot find MySQL header files under /usr.
Note that the MySQL client library is not bundled anymore!
 
    解决办法：
     yum install mysql-devel 

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

- 7.上述步骤走完，应该就能出来安装页面，在浏览器中输入www.hepinmeidu.com 开始安装

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

 * * * * * /home/wwwroot/www.hepinmeidu.com/script/queue/queue.sh /usr/bin/php >/dev/null

 * * * * * /home/wwwroot/www.hepinmeidu.com/script/crontab/crontab.php /usr/bin/php >/dev/null

- 3.在phpini中去掉 chroot,proc_open,proc_get_status

> disable_functions=passthru,exec,system,scandir,chgrp,chown,shell_exec,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassth

按照上面添加完crontab定时任务后发现，定时任务不能定时自动执行。但是手动执行一下/home/wwwroot/www.hepinmeidu.com/script/queue/queue.sh  这个脚本有用，那么请检查 每条crontab任务是否以空白行字符结尾，否则cron将认为计划（至少是部分的）被broken并拒绝建立该任务。


