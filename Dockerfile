FROM debian:stretch-slim
MAINTAINER KALRONG <xrb@kalrong.net>

WORKDIR /root
RUN sed -i "s#deb http://deb.debian.org/debian stretch main#deb http://deb.debian.org/debian stretch main non-free#g" /etc/apt/sources.list
RUN apt-get update; apt-get -y upgrade
RUN apt-get -y install unrar
RUN dpkg --add-architecture i386; apt-get update; apt-get -y install libc6:i386
ADD http://www.mysticbbs.com/downloads/mys112a39_l64.rar /root
RUN unrar-nonfree x mys112a39_l64.rar
ADD mystic/ /mystic/
RUN cp /root/upgrade /mystic/
WORKDIR /mystic/
RUN ./upgrade
HEALTHCHECK --interval=5m --timeout=3s  CMD curl -f https://kalrong.net/ || exit 1
ENTRYPOINT while true;do sleep 50000 ; done
