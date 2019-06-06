#!/bin/bash
set +e
echo "Go environment before setup:"
env | grep "^GO"
set -e

"$(dirname "$0")/../goinstall.sh"

source ~/.bashrc

echo "Go environment after setup:"
env | grep "^GO"

mkdir -p "$GOPATH/src/hello"
pushd "$GOPATH/src/hello"
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
go build
go install
hello
popd
