#!/bin/bash
set -e
set -o pipefail

echo "========================================="
echo "Starting"
echo "========================================="

#### I have to validate if ARTIFACT_URL is available
file="hello"

if [ -n "$ARTIFACT_URL" ]
then
  file=`basename "$ARTIFACT_URL"`
  wget -q --no-check-certificate --connect-timeout=5 --read-timeout=10 --tries=2 -O "$GOBIN/$file" "$ARTIFACT_URL"
  chmod 755 $GOBIN/$file
fi

pushd $GOBIN
$file
popd
