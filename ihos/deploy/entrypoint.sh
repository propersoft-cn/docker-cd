#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    echo "Pull deploy branch ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/ihos.git fe-deploy
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Cloning fe-deploy branch ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/ihos.git -b fe-deploy --depth=1 $WORKDIR
fi

# app-dev
cd $WORKDIR/app-dev
node proxy/proxy-server.js &
cd $WORKDIR/app-dev/www
python -m SimpleHTTPServer 9000 &

# app-master
cd $WORKDIR/app-master
sed -i "s/8080/8081/" proxy/proxy-server.js
node proxy/proxy-server.js &
cd $WORKDIR/app-master/www
python -m SimpleHTTPServer 9001 &

# admin
cd $WORKDIR/admin
sed -i "s/8080/8082/" proxy/proxy-server.js
node proxy/proxy-server.js &
cd $WORKDIR/admin/www
python -m SimpleHTTPServer 9002 &

# merge
cd $WORKDIR/merge
sed -i "s/8080/8083/" proxy/proxy-server.js
node proxy/proxy-server.js &
cd $WORKDIR/merge/www
python -m SimpleHTTPServer 9003 &