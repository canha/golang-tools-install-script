# golang-tools-install-script

Bash script to automate Go language tools single user installation (Linux) or even removal.
 * Golang version auto-detect function has been added

Tested with:

* Ubuntu/MacOSX Sierra (19/Apr/2018)

## How to use for golang install
```shell
curl -sL bit.ly/go_inst |bash

```

## Installation manually
To install on Linux 64bit:
```shell
curl -sL bit.ly/go_inst |bash -s "64"
```
  Or, to install 32-bit:

```shell
curl -sL bit.ly/go_inst |bash -s "32"
```

To install on macOS:
```shell
curl -sL bit.ly/go_inst |bash -s "darwin"
```

## Uninstall

```shell
curl -sL bit.ly/go_inst |bash -s "remove"
```

## Notes
The script will create `.go` and `go` folders on your home directory, add the needed variables and PATH expansion.

`$HOME/.go folder is your where Go will be installed to.`

`$HOME/go is the default workspace.`

Read more about the [workspace](http://golang.org/doc/code.html).
