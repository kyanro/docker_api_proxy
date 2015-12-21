#Ubuntu14.10をベースにする
FROM ubuntu:14.04

MAINTAINER kyanro

#インストールするもの
RUN apt-get update && apt-get -y upgrade
#RUN apt-get -y install build-essential
RUN apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc
#RUN apt-get -y install man
#RUN apt-get -y install manpages-ja

#日本語環境設定
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja

#環境変数設定
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

#ssh たてる
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD /usr/sbin/sshd -D
