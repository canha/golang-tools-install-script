#!/bin/bash
set -e

unset GOROOT
unset GOPATH
"$(dirname "$0")/../goinstall.sh" --mirror https://mirrors.ustc.edu.cn/golang --version "${REQVER}"
