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

cd $WORKDIR
node proxy/proxy-server.js &

cd $WORKDIR/www
python -m SimpleHTTPServer 9000
