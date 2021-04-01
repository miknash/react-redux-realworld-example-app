#!/bin/sh
BRANCH_NAME=$1
BUILD_NUMBER=$2

#echo $BUILD_ENV
#echo $BRANCH_NAME
#echo $BUILD_NUMBER

if [ -d "staging" ]; then rm -Rf staging; fi
if [ -d "production" ]; then rm -Rf production; fi

mkdir staging
mkdir production
tar -cf - --exclude './staging' --exclude './production' . | tar -xC staging
tar -cf - --exclude './staging' --exclude './production' . | tar -xC production

sed -i 's/conduit.productionready.io/staging.productionready.io/g' staging/src/agent.js
sed -i 's/conduit.productionready.io/production.productionready.io/g' production/src/agent.js

echo "Starting Staging Build"
cd staging
npm install
npm run build
cd build
tar zcf ${BRANCH_NAME}_${BUILD_NUMBER}.tar.gzip *
cd ..

echo "Starting Prduction build"
cd ../production
npm install
npm run build
cd build
tar zcf ${BRANCH_NAME}_${BUILD_NUMBER}.tar.gzip *


