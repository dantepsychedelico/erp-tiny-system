#!/bin/bash

BIAPP_VERSION=${BIAPP_VERSION-$(grep version bower.json | grep -o '[0-9.]*')}

case $1 in
    build)
        docker build -t biapp:$BIAPP_VERSION .
        ;;
    interactive)
        docker run -it --rm --net host \
            -u root \
            -v $PWD/gulp:/home/mean/gulp \
            -v $PWD/packages:/home/mean/packages \
            -v $PWD/config:/home/mean/config \
            biapp:$BIAPP_VERSION bash
        ;;
    develop)
        docker run -d --name "alpha-webapp-$BIAPP_VERSION" -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=10.5.128.116,10.5.128.117,10.5.128.118,10.5.128.119 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=10.5.128.116 \
            biapp:$BIAPP_VERSION gulp
        ;;
    production)
        docker run -d --name "alpha-webapp-$BIAPP_VERSION" -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=10.5.128.116 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=10.5.128.116 \
            biapp:$BIAPP_VERSION gulp production
        ;;
    test)
        docker run -it --rm -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=192.168.0.165:27017,192.168.0.165:27018 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=192.168.0.165 \
            biapp:$BIAPP_VERSION gulp
        ;;
    save)
        rm alpha-webapp-*.tar
        docker save --output alpha-webapp-$BIAPP_VERSION.tar biapp:$BIAPP_VERSION
        ;;
    load)
        LASTFILE=$(ls -t *tar | head -1)
        docker load --input $LASTFILE
        ;;
    pushFtp)
        UPLOADFILE=$(ls -t *tar | head -1)
        curl -T $UPLOADFILE "ftp://ftp.kyec.com.tw/Alpha_Info/$UPLOADFILE" --user "7755:7755@2014"
        ;;
    pullFtp)
        wget --user "7755" --password "7755@2014" ftp://ftp.kyec.com.tw/Alpha_Info/alpha-webapp-$BIAPP_VERSION.tar
        ;;
    *)
        echo "$(basename $0) :USAGE: [build]"
        exit 1
        ;;
esac
