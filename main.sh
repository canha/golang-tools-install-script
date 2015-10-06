#!/bin/bash

DFILE="go$1.linux-amd64.tar.gz"
if [ "$2" == "--remove" ]; then
    rm -rf "$HOME/.go$1/"
    rm -rf "$HOME/go$1/"
    sed -i '/# GoLang/d' "$HOME/.profile"
    sed -i '/export GOROOT/d' "$HOME/.profile"
    sed -i '/:$GOROOT/d' "$HOME/.profile"
    sed -i '/export GOPATH/d' "$HOME/.profile"
    sed -i '/:$GOPATH/d' "$HOME/.profile"
    echo "Go removed!"
    exit 0
else
    echo "supply a version or --remove to remove go."
fi

if [ -d "$HOME/.go$1" ] || [ -d "$HOME/go$1" ]; then
    echo "Installation directories already exist. Exiting."
    exit 1
fi

wget https://storage.googleapis.com/golang/$DFILE -O /tmp/go.tar.gz
if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

tar -C "$HOME" -xzf /tmp/go.tar.gz
mv "$HOME/go" "$HOME/.go$1"
touch "$HOME/.profile"
{
    echo -e "# Go $1 \
export GOROOT=$HOME/.go$1 \
export PATH=$PATH:$GOROOT/bin \
export GOPATH=$HOME/go$1 \
export PATH=$PATH:$GOPATH/bin"
} >> "$HOME"/.profile

mkdir -p "$HOME"/go"$1"/{src,pkg,bin}
source "$HOME/.profile"
rm -f /tmp/go.tar.gz
