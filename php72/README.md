#避免重复编辑时间过长分段编译
#基础就这个每次编译慢
docker build -t flashexpress/php:72-phalcon-s-m-r -f Dockerfile-phalcon .
#扩展最终使用用于生产
docker build -t flashexpress/php -f Dockerfile-flash .
