#!/bin/bash
set -e

#VERSION="1.10.4"
VERSION="$(curl -sL https://golang.org/dl |grep -e 'go1.' | head -1 | sed 's/<[^*]*.go1./go1./g' |awk -F '.' '{print $1"."$2"."$3 }')"

OS_TYPE="$(uname -s)-$(uname -m)"

print_help() {
    echo "Usage: bash goinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  32\t\tInstall 32-bit version"
    echo -e "  64\t\tInstall 64-bit version"
    echo -e "  arm\t\tInstall armv6 version"
    echo -e "  darwin\tInstall darwin version"
    echo -e "  remove\tTo remove currently installed version"
}

if [[ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]]; then
    # assume Zsh
    shell_profile="zshrc"
elif [[ -n "$($SHELL -c 'echo $BASH_VERSION')" ]]; then
    # assume Bash
    shell_profile="bashrc"
fi

	case $OS_TYPE in
		Linux-x86_64)
			SYSTEM="linux-amd64" ;;
		Linux-i686)
			SYSTEM="linux-386" ;;
		Darwin-x86_64)
			SYSTEM="darwin-amd64" ;;
		*)
			SYSTEM=""
			echo " ----------- You need to insert manually as below ----------" 
			print_help
			exit 1 ;;
	esac


	if [[ "$1" = "" ]];then
		DFILE="$VERSION.$SYSTEM.tar.gz"
	else
		case $1 in
			32)
				SYSTEM="linux-386" ;;
			64)
				SYSTEM="linux-amd64" ;;
			arm)
				SYSTEM="linux-armv6l" ;;
			darwin)
				SYSTEM="darwin-amd64" ;;
			remove)
					if [[ $HOME = "" ]];then
						echo "Wanning!!! Please make sure the \$HOME directory"
						exit 1
					fi 
				rm -Rfv $HOME/.go $HOME/go
				sed -i '/# GoLang/d' "$HOME/.${shell_profile}"
				sed -i '/export GOROOT/d' "$HOME/.${shell_profile}"
				sed -i '/:$GOROOT/d' "$HOME/.${shell_profile}"
				sed -i '/export GOPATH/d' "$HOME/.${shell_profile}"
				sed -i '/:$GOPATH/d' "$HOME/.${shell_profile}"
				echo "Go removed."
				exit 0 ;;
			help)
				print_help
				exit 0 ;;
			*)
				print_help
				exit 1 ;;
		esac
			DFILE="$VERSION.$SYSTEM.tar.gz"

	fi


if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ]; then
    echo "The 'go' or '.go' directories already exist. Exiting."
    exit 1
fi

echo "Downloading $DFILE ..."
curl -sL https://storage.googleapis.com/golang/$DFILE -o /tmp/go.tar.gz

if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Extracting File..."
tar -C "$HOME" -xzf /tmp/go.tar.gz
mv "$HOME/go" "$HOME/.go"
touch "$HOME/.${shell_profile}"
{
    echo '# GoLang'
    echo 'export GOROOT=$HOME/.go'
    echo 'export PATH=$PATH:$GOROOT/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
} >> "$HOME/.${shell_profile}"

mkdir -p $HOME/go/{src,pkg,bin}
echo -e "\nGo $VERSION was installed.\nMake sure to relogin into your shell or run:"
echo -e "\n\tsource $HOME/.${shell_profile}\n\nto update your environment variables."
echo "Tip: Opening a new terminal window usually just works. :)"
rm -f /tmp/go.tar.gz
