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

HC_HOME=/opt/hc
mkdir -p $HC_HOME
cd $HC_HOME
URL=https://cloud.propersoft.cn/teamcities/guestAuth/repository/downloadAll/IHos_Demo/lastSuccessful/artifacts.zip
echo 'Downloading from '$URL
curl -O $URL
if [ -e $HC_HOME/artifacts.zip ];
then
    echo 'Unziping artifacts.zip...'
    rm -rf $HC_HOME/www
    unzip -qq $HC_HOME/artifacts.zip -d $HC_HOME/www -x index.html *.apk
    rm -f $HC_HOME/artifacts.zip
    echo 'Done'
fi

# app-dev
if [ -d "$WORKDIR/app-dev" ];
then
    cd $WORKDIR/app-dev
    node proxy/proxy-server.js &
    cd $WORKDIR/app-dev/www
    python -m SimpleHTTPServer 9000 &
    cd $HC_HOME/www
    python -m SimpleHTTPServer 8000 &
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

# admin
if [ -d "$WORKDIR/admin" ];
then
    cd $WORKDIR/admin
    sed -i "s/8080/8082/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/admin/www
    python -m SimpleHTTPServer 9002 &
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
