#!/bin/sh
BRANCH_NAME=$1
BUILD_NUMBER=$2

#echo $BUILD_ENV
#echo $BRANCH_NAME
#echo $BUILD_NUMBER

mkdir staging
mkdir production
cp -r . staging
cp -r . production

sed -i 's/conduit.productionready.io/staging.productionready.io/g' staging/src/agent.js
sed -i 's/conduit.productionready.io/production.productionready.io/g' prod/src/agent.js

cd staging
npm install
npm build

cd ../production
npm install
npm build



