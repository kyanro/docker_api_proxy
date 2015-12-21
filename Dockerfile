#Ubuntu14.10をベースにする
FROM ubuntu:14.04

MAINTAINER kyanro

# packageのupgrade と、日本語環境、sshd、mitmproxyに必要なpackageをインストール
RUN apt-get update && apt-get -y upgrade && \
  apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc \
    openssh-server \
    python-pip python-dev libffi-dev libssl-dev \
      libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev

#日本語環境設定
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja

#環境変数設定
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

# mitmproxy のインストール
RUN pip install mitmproxy netlib

#ssh の設定. user:root, pass:root でアクセスできるようにする
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# sshd の起動とポート設定
EXPOSE 22
CMD /usr/sbin/sshd -D
