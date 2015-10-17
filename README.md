golang-tools-install-script
==========================

Bash script to automate Go language tools single user installation (Linux) or even removal.
Latest filename for download at the time of this writting was for version 1.5 of Go. Feel free to change the variables on the beggining to match whatever version you need.

Download with wget:
<blockquote>wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh</blockquote>

To install 64-bit
<blockquote>bash goinstall.sh --64</blockquote>

To install 32-bit:
<blockquote>bash goinstall.sh --32</blockquote>

To remove any changes call:
<blockquote>bash goinstall.sh --remove</blockquote>

The script will make .go and go folders on your home directory, add the needed variables and PATH expansion.

<blockquote>$HOME/.go folder is your where go will be installed to.</blockquote>
<blockquote>$HOME/go is the default workspace.</blockquote>

Read more about the workspace at http://golang.org/doc/code.html
