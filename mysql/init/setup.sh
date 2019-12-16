#!/bin/bash
set -e

#查看mysql服务的状态，方便调试，这条语句可以删除

echo '1.启动mysql....'
#启动mysql
#service mysql start
# sleep 3
# echo `service mysql status`

#重新设置mysql密码
# echo '4.开始修改密码....'
# mysql < /docker-entrypoint-initdb.d/init_database.sql
# echo '5.修改密码完毕....'

# #sleep 3
# # echo `service mysql status`
# echo 'mysql容器启动完毕,且数据导入成功'

# tail -f /dev/null
echo 123123 >> /root/1.txt