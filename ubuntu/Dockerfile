FROM ubuntu:22.04

LABEL maintainer="bugfix@gmail.com"

ENV TZ 'Asia/Shanghai' 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

RUN	sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
	&& apt update \
	&& apt install -y git zsh curl wget locales language-pack-en \
	&& locale-gen en_US.UTF-8 \
	&& sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
	&& sed -i 's/ZSH_THEME=".*"/ZSH_THEME="ys"/g' ~/.zshrc \
	&& sed -i 's/plugins=.*/plugins=(git zsh-autosuggestions)/g' ~/.zshrc \
	&& git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
	&& chsh -s /usr/bin/zsh

ENTRYPOINT ["/usr/bin/zsh"]
