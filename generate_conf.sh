#!/bin/bash

#ENVS="qat.*;qat;http://localhost:3000 uat.*;uat;http://localhost:3000 staging.*;staging;http://localhost:3000"
#DEFAULT="http://prod:3000"

if [ -z $DEFAULT ] ; then
	DEFAULT="http://localhost"
fi

TEMPLATE='if ($http_host ~ "<regex>") {\n  add_header X-env "<name>";\n  proxy_pass <url>;\n}\n'
LINES=""
for ENV in $ENVS ; do
	#echo $ENV

	REGEX=`echo $ENV | cut -d';' -f1`
	NAME=`echo $ENV | cut -d';' -f2`
	URL=`echo $ENV | cut -d';' -f3`

	T="${TEMPLATE//<regex>/$REGEX}"
	T="${T//<name>/$NAME}"
	T="${T//<url>/$URL}"

	LINES="$LINES$T"
done

#LINES="${LINES//\n/\n}"

cat << %EOF% > conf.conf
server {
  listen      80;
  server_name localhost;
  
  location / {

%EOF%

echo -e $LINES >> conf.conf

cat << %EOF% >> conf.conf
    proxy_set_header                Host \$http_host;
    proxy_pass_request_headers      on;
    proxy_pass                      $DEFAULT;
  }
}
%EOF%



