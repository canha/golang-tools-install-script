# golang-tools-install-script

Bash script to automate Go language tools single user installation or even removal.

Feel free to change the variables on the beggining to match whatever version of Go you need.

Tested with:

* Ubuntu 18.04 and later (06/2019)
* macOS Mojave (06/2019)

## Requirements
* wget or curl
* Bash shell

## Downloading the script

Download with wget, curl or clone the repository

```shell
wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh
```

```shell
curl https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh -O
```

```shell
git clone https://github.com/canha/golang-tools-install-script.git
```
## Installation examples

To install on Linux:
```shell
bash goinstall.sh --64
```

  Or, to install 32-bit:

```shell
bash goinstall.sh --32
```

To install on macOS:

```shell
bash goinstall.sh --darwin
```

## Uninstall

```shell
bash goinstall.sh --remove
```

## Notes

By default the script will create `.go` and `go` folders on your home directory, add the needed variables and PATH expansion.

`$HOME/.go is location where Go will be installed to.`

`$HOME/go is the default workspace.`

In order to install Go to other location and set custom workspace set environment variables `GOROOT` and `GOPATH` before installing (uninstalling) Go tools:
```shell
export GOROOT=/opt/go
export GOPATH=$HOME/projects/go
```
Read more about the [workspace](http://golang.org/doc/code.html).
