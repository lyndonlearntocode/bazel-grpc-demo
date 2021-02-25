# Cerence Cloud Public and internal APIs

This repository contains the interface definitions of public and internal Cerence APIs that support gRPC protocols.

## Definition

**Public APIs** are visible from outside of Cerence Cloud. You can find them in the folder `proto/public`

**Internal APIs** are APIs between micro-services and can be found in `proto/internal`

We want to share types/includes if possible. It’s better if those are all in the same repo (following Google’s example).

**Private APIs** (inside a micro-service) should not be stored in this repo. They can
include protos from [this repo](https://git.labs.hosting.derence.net/onecloud/apis)
but not vice versa.


## Governance

We use [buf.build](https://buf.build/) to check 
* that all protobuf files compile
* that all protobuf files conform with our lint rules
* that no breaking changes are committed to the master branch

The build pipeline will also output generated Java and Python code, as well as HTML documentation. You can download them as artifacts of each build pipeline. 

Windows support is not yet available for [buf.build](https://buf.build/).  Instructions on running
buf.build from a docker container can be found [here](BUF.md)


## Documentation

The documentation is automatically generated and published in [apis-doc](https://git.labs.hosting.derence.net/onecloud/apis-doc).

## Dependency graph for internal interfaces

![](/graph/internal_interfaces_dependencies.png)