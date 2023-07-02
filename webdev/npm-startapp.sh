#!/bin/bash

set -euo pipefail

echo -e "\n##\n##\tRUNNING WITH ENVIRONMENT=\"${NODE_ENV}\"\n##\n\n"

#
#
# 

echo -e "Start app...\n"

if [ "${NODE_ENV}" == "test" ]
then
	npm run serve:test
fi

if [ "${NODE_ENV}" == "development" ]
then
  npm run serve:dev
fi

if [ "${NODE_ENV}" == "production" ]
then
	npm run build
else
  echo -ne "Invalid argument. Allowed values are: 'dev', 'test', 'prod'\n\n"
fi
