#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    echo "Pull deploy branch ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/ionic-sj.git deploy
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Clone deploy branch ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/ionic-sj.git -b deploy --depth=1 $WORKDIR
fi

cd $WORKDIR
node proxy/proxy-server.js &

cd $WORKDIR/www
python -m SimpleHTTPServer 9000
