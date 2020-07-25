# golang-tools-install-script [![Build Status](https://travis-ci.org/canha/golang-tools-install-script.svg?branch=master)](https://travis-ci.org/canha/golang-tools-install-script)

Bash script to automate installation and removal of single user Go language tools.

Feel free to change the variables on the beginning to match whatever version of Go you need.

Tested working on:

* :white_check_mark: Ubuntu 16.04 to 18.04
* :white_check_mark: macOS Sierra (10.12) to Catalina (10.15)

## :hammer: Requirements
* `wget` or `curl`
* Bash shell

## :fast_forward: Install

Download and run with `wget` or `curl`:

```shell
# Linux typically has wget installed
wget -q -O - https://git.io/vQhTU | bash

# macOS typically has curl installed
curl -L https://git.io/vQhTU | bash
```

## :package: Version

Pass the `--version` option into the script including the version that you wish to install. This specify a different version without needing to change the variable in the script.

##### Example:

```shell
wget -q -O - https://git.io/vQhTU | bash -s -- --version 1.13.2

# or...
curl -L https://git.io/vQhTU | bash -s -- --version 1.13.2
```

## :no_entry_sign: Uninstall

Pass the `--remove` option into the script:

```shell
wget -q -O - https://git.io/vQhTU | bash -s -- --remove

# or...
curl -L https://git.io/vQhTU | bash -s -- --remove
```

## :pencil: Notes

By default the script will create `.go` and `go` folders on your home directory, add the needed variables and `PATH` expansion.

`$HOME/.go is the directory where Go will be installed to.`

`$HOME/go is the default workspace directory.`

Read more about the [workspace](http://golang.org/doc/code.html).

In order to install Go into another location, set the environment variables `$GOROOT` and `$GOPATH` before (un)installing:

```shell
export GOROOT=/opt/go
export GOPATH=$HOME/projects/go
```
