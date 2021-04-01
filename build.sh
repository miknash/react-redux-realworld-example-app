#!/bin/sh
BRANCH_NAME=$1
BUILD_NUMBER=$2

#echo $BUILD_ENV
#echo $BRANCH_NAME
#echo $BUILD_NUMBER

mkdir staging
mkdir production
tar -cf - --exclude './staging' --exclude './production' . | tar -xC staging
tar -cf - --exclude './staging' --exclude './production' . | tar -xC production

sed -i 's/conduit.productionready.io/staging.productionready.io/g' staging/src/agent.js
sed -i 's/conduit.productionready.io/production.productionready.io/g' production/src/agent.js

cd staging
npm install
npm build

cd ../production
npm install
npm build



