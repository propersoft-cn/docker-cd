#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    git checkout .
    echo "Pull deploy branch ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/icmp.git fe-deploy
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Cloning fe-deploy branch ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/icmp.git -b fe-deploy --depth=1 $WORKDIR
fi

# app-dev
if [ -d "$WORKDIR/app-dev" ];
then
    cd $WORKDIR/app-dev
    node proxy/proxy-server.js &
    cd $WORKDIR/app-dev/www
    python -m SimpleHTTPServer 9000 &
fi

# app-master
if [ -d "$WORKDIR/app-master" ];
then
    cd $WORKDIR/app-master
    sed -i "s/8080/8081/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/app-master/www
    python -m SimpleHTTPServer 9001 &
fi

# merge
if [ -d "$WORKDIR/merge" ];
then
    cd $WORKDIR/merge
    sed -i "s/8080/8083/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/merge/www
    python -m SimpleHTTPServer 9003 &
fi

tail -f /dev/null
