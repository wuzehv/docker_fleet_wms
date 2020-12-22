FROM php:7.2-fpm-alpine

LABEL maintainer="bugfixeng@gmail.com"

ENV PHALCON_VERSION=4.0.6
ENV REDIS_VERSION=4.2.0
ENV TIME_ZONE Asiz/Shanghai

# 修改镜像源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
		libmcrypt-dev \
        git \
        imagemagick \
        zlib \
    && pecl install psr \
    && docker-php-ext-enable psr \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-install \
        bcmath \
        pdo_mysql \
        pcntl \
        sockets \
        zip \
        pcntl \
    && rm -rf /tmp/pear

RUN apk add icu icu-dev icu-libs && docker-php-ext-install intl

RUN apk add \
    freetype-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libmcrypt-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && rm -rf /tmp/pear

WORKDIR /usr/local/etc/php
RUN cp php.ini-development php.ini

# Compile Phalcon
RUN set -xe && \
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && ./install && \
    echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini && \
    cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION}

# 安装composer并允许root用户运行
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/local/share/composer
RUN mkdir -p /usr/local/share/composer \
	&& curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
	&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
	&& rm -f /tmp/composer-setup.* \
    # Insall Phalcon Devtools(国内镜像没有这个包，所以需要放在前面)
    && composer global require phalcon/devtools \
    # && echo "export PATH=\$PATH:/usr/local/share/composer/vendor/phalcon/devtools" >> ~/.bashrc \
    # 配置composer中国全量镜像
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

#redis的安装指定版本
RUN set -xe && \
    curl -LO http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz && \
    pecl install redis-${REDIS_VERSION}.tgz && \
    #echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    docker-php-ext-enable redis && \
    rm -rf redis-${REDIS_VERSION}.tar.gz

#清理安装过的包
RUN apk del .build-deps

# 对其他容器开放9000端口
EXPOSE 9000

# 使用bash
RUN apk add bash bash-doc && echo "alias ll='ls -l'" >> ~/.bashrc && source ~/.bashrc
