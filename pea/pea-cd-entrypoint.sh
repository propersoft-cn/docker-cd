#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    echo "Pull deploy branch ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/proper-enterprise-app.git deploy
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Clone deploy branch ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/proper-enterprise-app.git -b deploy --depth=1 $WORKDIR
fi

# master
if [ -d "$WORKDIR/master" ];
then
    cd $WORKDIR/master
    node proxy/proxy-server.js &
    cd $WORKDIR/master/dist
    python -m SimpleHTTPServer 9000 &
fi

tail -f /dev/null