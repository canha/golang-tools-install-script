#!/bin/bash
VERSION="1.2.1"

if [ "$1" == "--32" ]; then
    DFILE="go$VERSION.linux-386.tar.gz"
elif [ "$1" == "--64" ]; then
    DFILE="go$VERSION.linux-amd64.tar.gz"
elif [ "$1" == "--remove" ]; then
    rm -rf $HOME/.go/
    rm -rf $HOME/go/
    sed -i '/# GoLang/d' $HOME/.profile
    sed -i '/export GOROOT/d' $HOME/.profile
    sed -i '/:$GOROOT/d' $HOME/.profile
    sed -i '/export GOPATH/d' $HOME/.profile
    sed -i '/:$GOPATH/d' $HOME/.profile
    echo "Go removed!"
    exit 0
else
    echo "Please use --32 or --64 as the argument to this script to specify the version to install. Exiting."
    exit 1
fi

if [ -d $HOME/.go ] || [ -d $HOME/go ]; then
    echo "Installation directories already exist. Exiting."
    exit 1
fi
wget https://go.googlecode.com/files/$DFILE -O /tmp/go.tar.gz
if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

tar -C $HOME -xzf /tmp/go.tar.gz
mv $HOME/go $HOME/.go
touch $HOME/.profile
echo '# GoLang' >> $HOME/.profile
echo 'export GOROOT=$HOME/.go' >> $HOME/.profile
echo 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.profile
mkdir -p $HOME/go/src
mkdir -p $HOME/go/pkg
mkdir -p $HOME/go/bin
echo 'export GOPATH=$HOME/go' >> $HOME/.profile
echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.profile
source $HOME/.profile
rm -f /tmp/go.tar.gz
