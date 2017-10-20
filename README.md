# golang-tools-install-script

Bash script to automate Go language tools single user installation (Linux) or even removal.
Latest filename for download at the time of this writting was for version 1.9.1 of Go. Feel free to change the variables on the beggining to match whatever version you need.
By default the script export env variables in .bashrc but you can pass it the flag --zsh if you are a zsh user for write the exports in your .zshrc .

Tested with:
 - Ubuntu/Mint/Debian (17/10/2015)
 - Ubuntu (20/10/2017)
 - MacOSX Sierra (Darwin)

### 1. Download with wget or your preferred download method:
```shell
$ wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh
```

### 2. To install 64-bit
```shell
$ bash goinstall.sh --64
```

  Or, to install 32-bit:
```shell
$ bash goinstall.sh --32
```

### 3. To install on Darwin
```shell
$ bash goinstall.sh --darwin
```
### 3. To remove any changes call:
```shell
$ bash goinstall.sh --remove
```

The script will make .go and go folders on your home directory, add the needed variables and PATH expansion.

<blockquote>$HOME/.go folder is your where go will be installed to.</blockquote>
<blockquote>$HOME/go is the default workspace.</blockquote>

Read more about the workspace at http://golang.org/doc/code.html
