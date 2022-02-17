#!/bin/bash

kp image save kpack-angular --tag th3n3rd/kpack-angular --builder builder --local-path . --wait
docker pull th3n3rd/kpack-angular
