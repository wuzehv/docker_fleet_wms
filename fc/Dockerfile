FROM php:7.4-fpm-alpine3.12

LABEL maintainer="bugfix@gmail.com"

ENV REDIS_VERSION=5.0.2 \
    TIME_ZONE=Asia/Shanghai

# 修改镜像源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装依赖,核心扩展,pecl扩展,git,composer 工具
RUN apk add -U --no-cache \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
        libmcrypt \
        libpq \
        libgomp \
        freetype \
        libjpeg \
        libpng \
        libmcrypt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        php7-mysqli \
        php7-mcrypt \
        php7-mbstring \
        imagemagick \
        mysql-client \
        postgresql-libs \
        icu \
        icu-dev \
        icu-libs \
        curl \
        openssh \
        git \
        tzdata \
        oniguruma-dev \
        zip libzip-dev cairo \
        #设置时区
        && echo "${TIME_ZONE}" > /etc/timezone \ 
        && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    # 配置npm中国镜像
    && pecl install xlswriter imagick apcu yac mcrypt-1.0.1 \
    && docker-php-ext-enable xlswriter apcu yac imagick \
    && docker-php-ext-install \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        pcntl \
        tokenizer \
        xml \
        zip \
        bcmath \
        mysqli \
        sockets \
        intl \
        exif \
	&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && apk del \
    && rm -rf /var/cache/apk/* /tmp/pear ~/.composer/cache/*

# 安装composer并允许root用户运行
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/local/share/composer
RUN mkdir -p /usr/local/share/composer \
	&& curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
	&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
	&& rm -f /tmp/composer-setup.* \
    # 配置composer中国全量镜像
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

#redis的安装指定版本
RUN set -xe && \
    curl -LO http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz && \
    pecl install redis-${REDIS_VERSION}.tgz && \
    #echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    docker-php-ext-enable redis && \
    rm -rf redis-${REDIS_VERSION}.tar.gz

# 对其他容器开放9000端口
EXPOSE 9000
