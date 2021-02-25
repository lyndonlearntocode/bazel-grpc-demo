# Running Buf 

#### Windows support is not yet available for [Buf](https://buf.build/).  Follow these procedures to run it from a docker container instead.

Start the container with the buf build and protoc image with a dummy command.  It will return the container id, e.g.:

`> docker run -d artifactory.prod.cre.az-eastus2.hosting.nuautoco.com/onecloud-docker/buf-build-protoc:590156 sleep 1d 
 728bae17a7d80832f7300d31066e35b1cbaae36a9e61a54c7107f6c25ffcb07c`


Copy the protobuf files to the container.  Files copied to the container are created with UID:GID of the root user.  For example, to copy protobuf files contained in a folder called apis to the directory /src/proto:

`> docker cp apis 728bae17a7d8:/src/proto
`

Attach to the running container as the root user.
  
`> docker exec -u 0 -it 728bae17a7d8 bash
`

Execute the buf build command:

`root@728bae17a7d8:/src/proto# cd apis` 

`root@728bae17a7d8:/src/proto/apis/proto# buf image build -o image.bin`

Run the lint checker:

`root@728bae17a7d8:/src/proto/apis# buf check lint`

Optionally, stop or remove the container

`> docker stop 728bae17a7d8 `

Or

`> docker rm -f 728bae17a7d8`

