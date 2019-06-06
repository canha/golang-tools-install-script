# golang-tools-install-script

Bash script to automate Go language tools single user installation or even removal.

Feel free to change the variables on the beggining to match whatever version of Go you need.

Tested with:

* Ubuntu 18.04 and later (06/2019)
* macOS Mojave (06/2019)

## Requirements
* `wget` or `curl`
* Bash shell

## Quick install

Download and run with `wget` or `curl`:

```shell
# Linux typically has wget installed
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

# Curl is generally available on macOS
curl https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
```

## Uninstall

Pass the `--remove` option into the script:
```shell
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash -s -- --remove

# Or if using curl
curl https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash -s -- --remove
```

## Notes

By default the script will create `.go` and `go` folders on your home directory, add the needed variables and PATH expansion.

`$HOME/.go is the directory where Go will be installed to.`

`$HOME/go is the default workspace directory.`

Read more about the [workspace](http://golang.org/doc/code.html).

In order to install Go into another location, set the environment variables `$GOROOT` and `$GOPATH` before installing (or uninstalling):
```shell
export GOROOT=/opt/go
export GOPATH=$HOME/projects/go
```
