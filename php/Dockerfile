FROM php:7.2-fpm-alpine

LABEL maintainer="bugfix@gmail.com"

ENV PHALCON_VERSION=3.3.2
ENV REDIS_VERSION=4.2.0
ENV SWOOLE_VERSION=4.2.0
ENV TIME_ZONE Asiz/Shanghai

# 修改镜像源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装依赖,核心扩展,pecl扩展,git,composer 工具
RUN apk add -U --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
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
        #安装tzdata安装包 空镜像空的没有了时区
    && apk add --no-cache \
        curl \
        openssh \
        git \
        tzdata \  
        #设置时区
        && echo "${TIME_ZONE}" > /etc/timezone \ 
        && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    # 配置npm中国镜像
    && pecl install imagick \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable imagick \
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
	&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && rm -rf /tmp/pear

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

# Compile Phalcon
RUN set -xe && \
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && ./install && \
    echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini && \
    cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION}
    # Insall Phalcon Devtools, see https://github.com/phalcon/phalcon-devtools/
    #curl -LO https://github.com/phalcon/phalcon-devtools/archive/v${PHALCON_VERSION}.tar.gz && \
    #tar xzf v${PHALCON_VERSION}.tar.gz && \
    #mv phalcon-devtools-${PHALCON_VERSION} /usr/local/phalcon-devtools && \
    #ln -s /usr/local/phalcon-devtools/phalcon.php /usr/local/bin/phalcon 

#redis的安装指定版本
RUN set -xe && \
    curl -LO http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz && \
    pecl install redis-${REDIS_VERSION}.tgz && \
    #echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    docker-php-ext-enable redis && \
    rm -rf redis-${REDIS_VERSION}.tar.gz

RUN echo "alias ll='ls $LS_OPTIONS -l'" >> ~/.bashrc && \
    source ~/.bashrc

#清理安装过的包
RUN apk del .build-deps

# 对其他容器开放9000端口
EXPOSE 9000
