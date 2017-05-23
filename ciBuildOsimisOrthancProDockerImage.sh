#!/bin/bash

set -x #to debug the script
set -e #to exit the script at the first failure

root=${REPOSITORY_PATH:-$(git rev-parse --show-toplevel)}

cd $root/docker

# let's build the 'pro image'
mkdir -p binaries/plugins-pro

# fetch mssql so file
wget orthanc.osimis.io/docker-so/mssql/0.4.0/libOrthancMsSqlIndex.so -O binaries/plugins-pro/libOrthancMsSqlIndex.so # CHANGE_VERSION


containerId=$(docker create osimis/osimis-webviewer-pro:09431e1) # CHANGE_VERSION
docker cp $containerId:/usr/share/orthanc/plugins/libOsimisWebViewerPro.so binaries/plugins-pro/

docker build $@ -t osimis/orthanc-pro:17.5.beta -f orthanc-pro/Dockerfile . # CHANGE_VERSION