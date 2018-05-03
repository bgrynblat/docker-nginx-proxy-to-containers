#!/bin/bash

bash -c /generate_conf.sh
cp conf.conf /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'