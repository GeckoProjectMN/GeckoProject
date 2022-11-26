FROM debian:stretch
LABEL maintainer="Geckocoin Developers <dev@geckocoin.org>"
LABEL description="Dockerised GeckocoinCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
