```
数据库中链接地址直接填写[mysql] 
端口   3306
用户名 root 
密码   root
```
``` bash
#进入mysql 容器
docker exec -it mysql bash
#进入数据库
mysql
#选择库
use mysql;
#设置密码
update user set authentication_string = password('root') where user = 'root';
#设置权限
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
#退出
exit
```
