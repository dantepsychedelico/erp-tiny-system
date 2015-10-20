FROM node:4.2.1

MAINTAINER Zac Chung

RUN apt-get update && \
	apt-get install -y ssh vim git

RUN	npm install -g bower && \
	npm install -g gulp && \
	useradd -m mean

RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

ADD . /home/mean

RUN chown mean:mean -R /home/mean

USER mean

WORKDIR /home/mean

# RUN npm install

# CMD ["gulp", "production"]
