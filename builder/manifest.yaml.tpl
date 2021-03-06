apiVersion: v1
kind: ServiceAccount
metadata:
  name: builder-service-account
  namespace: default
secrets:
  - name: image-registry-credentials
imagePullSecrets:
  - name: image-registry-credentials
---
apiVersion: kpack.io/v1alpha2
kind: ClusterStore
metadata:
  name: default
spec:
  sources:
  - image: gcr.io/paketo-buildpacks/ca-certificates
  - image: gcr.io/paketo-buildpacks/node-engine
  - image: gcr.io/paketo-buildpacks/npm-install
  - image: gcr.io/paketo-buildpacks/node-module-bom
  - image: gcr.io/paketo-buildpacks/node-run-script
  - image: gcr.io/paketo-buildpacks/nginx
---
apiVersion: kpack.io/v1alpha2
kind: ClusterStack
metadata:
  name: base
spec:
  id: "io.buildpacks.stacks.bionic"
  buildImage:
    image: "paketobuildpacks/build:base-cnb"
  runImage:
    image: "paketobuildpacks/run:base-cnb"
---
apiVersion: kpack.io/v1alpha2
kind: Builder
metadata:
  name: builder
spec:
  serviceAccount: builder-service-account
  tag: $USERNAME/builder
  stack:
    name: base
    kind: ClusterStack
  store:
    name: default
    kind: ClusterStore
  order:
  - group:
    - id: paketo-buildpacks/ca-certificates
    - id: paketo-buildpacks/node-engine
    - id: paketo-buildpacks/npm-install
    - id: paketo-buildpacks/node-module-bom
    - id: paketo-buildpacks/node-run-script
    - id: paketo-buildpacks/nginx
