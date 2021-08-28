#!/bin/bash
set -e

mkdir -p "/tmp/validate-go"
pushd "/tmp/validate-go"
go mod init example.com/user/hello
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
echo "Building hello test project"
go build
echo "Run hello test project"
./hello
popd
