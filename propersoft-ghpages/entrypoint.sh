#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    echo "Pull gh pages ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/propersoft-cn.github.io.git
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Clone gh pages ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/propersoft-cn.github.io.git --depth=1 $WORKDIR
fi

cd $WORKDIR
python -m SimpleHTTPServer 80
