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

cd $WORKDIR

s_token='eyJpZCI6ImRjNjU3NjZjLTAxNzYtNGExZS1hZDBlLWRkMDZiYTY0NWM3bCIsIm5hbWUiOiJhZG1pbiJ9.eyJlbXBOYW1lIjpudWxsLCJyb2xlcyI6ImEsYixjIn0.jgFLzfaFjADFUfti3jGMNqhYb1KN1anU8OkXKh3uKwk'

t_token='cHJvcGVyOnByb3BlckBwYXNz'

sed -i s#$s_token#$t_token#g $WORKDIR/proxy/modules/auth/login/handler.js 
sed -i s#'Bearer '#'Basic '#g $WORKDIR/dist/scripts/scripts.* 
node proxy/proxy-server.js &

cd $WORKDIR/dist
python -m SimpleHTTPServer 9000