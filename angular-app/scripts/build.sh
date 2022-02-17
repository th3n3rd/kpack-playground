#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
TAG=${1:-"th3n3rd/kpack-angular-app"}

cd "$SCRIPT_DIR/.."

echo "Make sure the docker cli is already authenticated with the registry"

echo "Building the angular application using cloud native buildpacks"
kp image save kpack-angular-app \
  --tag "$TAG" \
  --builder builder \
  --local-path . \
  --wait
