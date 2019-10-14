set -e
echo "Go environment after setup:"
env | grep "^GO"

mkdir -p "$GOPATH/src/hello"
pushd "$GOPATH/src/hello"
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
echo "Building hello test project"
go build
echo "Install hello test project"
go install
echo "Run hello test project"
hello
popd

GOVER=`go version`

echo "Testing to make sure that Go $REQVER is installed"

if grep -q "$REQVER" <<< "$GOVER"; then
	echo "Version contains: $REQVER"
	exit 0
else
	echo "Does not contain: $REQVER"
	exit 1
fi
