# golang-tools-install-script

Bash script to automate Go language tools single user installation (Linux) or even removal.
Latest filename for download at the time of this writting was for version 1.9.3 of Go. Feel free to change the variables on the beggining to match whatever version you need.

Tested with:

* Ubuntu/MacOSX Sierra (29/10/2017)

## Installation

Download with wget or clone the repository

```shell
wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh
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

The script will create `.go` and `go` folders on your home directory, add the needed variables and PATH expansion.

`$HOME/.go folder is your where Go will be installed to.`

`$HOME/go is the default workspace.`

Read more about the [workspace](http://golang.org/doc/code.html).
