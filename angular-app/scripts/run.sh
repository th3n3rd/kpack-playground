#!/bin/bash

TAG=${1:-"th3n3rd/kpack-angular-app"}

echo "Running the angular application container on http://localhost:8080"
docker run -it --rm -p "8080:80" "$TAG"
