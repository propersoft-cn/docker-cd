#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    git checkout .
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
    S='"./api"'
    T='location.protocol+"//"+location.host+"/pea/pep"'

    sed -i "s#$S#$T#g" dist/scripts/scripts*
    sed -i "s/8080/8081/" proxy/proxy-server.js
    #node proxy/proxy-server.js &
    cd $WORKDIR/master/dist
    python -m SimpleHTTPServer 9001 &
fi

# merge
if [ -d "$WORKDIR/merge" ];
then
    cd $WORKDIR/merge
    sed -i "s/8080/8083/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/merge/dist
    python -m SimpleHTTPServer 9003 &
fi

# ng2
if [ -d "$WORKDIR/ng2" ];
then
    cd $WORKDIR/ng2
    S='<base href="/">'
    T='<base href="/pea/ng2/">'

    sed -i "s#$S#$T#g" dist/index.html
    sed -i "s/8080/8084/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/ng2/dist
    python -m SimpleHTTPServer 9004 &
fi

# master
if [ -d "$WORKDIR/master" ];
then
    cd $WORKDIR/master
    S='<base href="/">'
    T='<base href="/pea/master/">'

    sed -i "s#$S#$T#g" dist/index.html
    sed -i "s/8080/8085/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/master/dist
    python -m SimpleHTTPServer 9005 &
fi


tail -f /dev/null
