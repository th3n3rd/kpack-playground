#!/bin/bash

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
export USERNAME=${1:-"th3n3rd"}

if ! kubectl get secret image-registry-credentials ; then
  echo "Storing registry (dockerhub) credentials for the builder"
  # https://github.com/vmware-tanzu/kpack-cli/issues/155
  kp secret create image-registry-credentials --dockerhub "$USERNAME"
fi

echo "Deploying the builder"
envsubst < "$SCRIPT_DIR/manifest.yaml.tpl" | kubectl apply -f -
