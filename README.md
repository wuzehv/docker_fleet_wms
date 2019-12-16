#mac 下使用请在User 目录下使用，这个是mac用当ubuntu、centos 使用
#使用第一步 安装docker 
* nginx php redis memcache
* php -m redis mysql swoole memcache


## 后台编排运行资源 进入clone的文件夹
```
docker-compose up -d
```

## 目录结构
和docker-lnmp 同级的flash 目录下即可
volumes:
   - ../flash/bi:/mnt/www/bi.flashexpress.com
## 效果图
``` 
docker ps
```
![容器列表](https://gitee.com/uploads/images/2018/0523/215151_1d8f3198_87619.png "2.png")

## 容器使用
```
docker exec -it mysql bash
# 内部执行 安装 
docker exec myphp compose install


```
### 使用方法一
```
nginx  nginx/conf.d/default.conf.example >default.conf
docker-compose.yml.example > docker-compose.yml
```
### 使用方法二
```
php 框架或是代码中，涉及链接(无须填写127.0.0.1 ,这个是docker的机制)
reids => myredis  
mysql => mysql 
memcached => mymemcache 
的直接使用无需关心
```
### 外部调用内部命令 三
```
docker exec -it myphp bash -c "cd /usr/share/nginx/{path} &&  composer install"
安装系统中 如果出现 php-git 缺，那是没有配置git的的ssh 请进入容器 执行git公共密钥
```
docker build -t alex/php:72 .
logstash 驱动
https://segmentfault.com/a/1190000014852507
https://www.elastic.co/downloads/logstash
bin/logstash-plugin install logstash-output-jdbc
bin/logstash-plugin install logstash-input-jdbc

https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.zip
