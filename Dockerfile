FROM node:0.12

MAINTAINER Zac Chung

RUN apt-get update && \
	apt-get install -y ssh vim 

RUN npm install -g mean-cli && \
	npm install -g bower && \
	npm install -g gulp && \
    npm install -g browser-sync && \
	useradd -m mean

RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

ADD . /home/mean

RUN chown mean:mean -R /home/mean

USER mean

WORKDIR /home/mean

RUN npm install

CMD ["gulp", "production"]
