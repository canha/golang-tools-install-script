#!/bin/bash
if [ "$1" == "--32" ]; then
    DFILE="go1.2.linux-386.tar.gz"
elif [ "$1" == "--64" ]; then
    DFILE="go1.2.linux-amd64.tar.gz"
elif [ "$1" == "--remove" ]; then
    rm -rf $HOME/.go/
    rm -rf $HOME/go/
    sed -i '/# GoLang/d' .profile
    sed -i '/export GOROOT/d' .profile
    sed -i '/:$GOROOT/d' .profile
    sed -i '/export GOPATH/d' .profile
    sed -i '/:$GOPATH/d' .profile
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
mv go/ .go/
echo '# GoLang' >> .profile
echo 'export GOROOT=$HOME/.go' >> .profile
echo 'export PATH=$PATH:$GOROOT/bin' >> .profile
mkdir -p $HOME/go/src
mkdir -p $HOME/go/pkg
mkdir -p $HOME/go/bin
echo 'export GOPATH=$HOME/go' >> .profile
echo 'export PATH=$PATH:$GOPATH/bin' >> .profile
source .profile
rm -f /tmp/go.tar.gz
