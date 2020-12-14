# Demo to build grpc library for different languages

Please refer to <https://github.com/rules-proto-grpc/rules_proto_grpc>

## Build python

```bash
# cd into folder and build
$ cd src/build/python
$ bazel build :greeter_python_grpc
```

## Build java

```bash
# cd into folder and build
$ cd src/build/java
$ bazel build :greeter_java_library
```