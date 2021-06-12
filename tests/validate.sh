#!/bin/bash
set -e
echo "Go environment after setup:"
env | grep "^GO"

mkdir -p "hello"
pushd "hello"
echo "Writing hello.go"
cat >hello.go <<EOF
package main

import (
    "fmt"
    "runtime"
)

func main() {
    fmt.Printf("go version %s %s/%s\n", runtime.Version(), runtime.GOOS, runtime.GOARCH)
}
EOF
go mod init github.com/canha/golang-tools-install-script/test
echo "Building hello test project"
go build
echo "Install hello test project"
go install
echo "Run hello test project"
hello
popd
