#!/bin/bash

APPVERSION=${APPVERSION-$(grep version bower.json | grep -o '[0-9.]*')}
APPNAME=${APPNAME-$(grep name bower.json | grep -o '"[^"]*",' | sed 's/[",]//g')}

case $1 in
    build)
        docker build -t $APPNAME:$APPVERSION .
        ;;
    interactive)
        docker run -it --rm --net host \
            -u root \
            -v $PWD/gulp:/home/mean/gulp \
            -v $PWD/packages:/home/mean/packages \
            -v $PWD/config:/home/mean/config \
            $APPNAME:$APPVERSION bash
        ;;
    develop)
        docker run -d --name "alpha-webapp-$APPVERSION" -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=10.5.128.116,10.5.128.117,10.5.128.118,10.5.128.119 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=10.5.128.116 \
            $APPNAME:$APPVERSION gulp
        ;;
    production)
        docker run -d --name "alpha-webapp-$APPVERSION" -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=10.5.128.116 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=10.5.128.116 \
            $APPNAME:$APPVERSION gulp production
        ;;
    test)
        docker run -it --rm -p 4000:3000 \
            -e DB_PORT_27017_TCP_ADDR=192.168.0.165:27017,192.168.0.165:27018 \
            -e DB_PORT_27017_DATABASE=BIDATA_All_ver1 \
            -e MS_ADDR=192.168.0.165 \
            $APPNAME:$APPVERSION gulp
        ;;
    save)
        rm alpha-webapp-*.tar
        docker save --output alpha-webapp-$APPVERSION.tar $APPNAME:$APPVERSION
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
        wget --user "7755" --password "7755@2014" ftp://ftp.kyec.com.tw/Alpha_Info/alpha-webapp-$APPVERSION.tar
        ;;
    startGulp)
        LIVERELOAD_PORT=35729 DEBUG_PORT=5858 PORT=3000 DB_PORT_27017_TCP_ADDR=127.0.0.1 gulp
        ;;
    *)
        echo "$(basename $0) :USAGE: [build]"
        exit 1
        ;;
esac
