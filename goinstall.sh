#!/bin/bash
# shellcheck disable=SC2016
set -e

FALLBACK_VERSION="1.24.4"
VERSION="$FALLBACK_VERSION"

[ -z "$GOROOT" ] && GOROOT="$HOME/.go"
[ -z "$GOPATH" ] && GOPATH="$HOME/go"

# Function to detect the latest Go version from go.dev
get_latest_version() {
    local latest_version=""

    if hash wget 2>/dev/null; then
        latest_version=$(wget -qO- "https://go.dev/VERSION?m=text" 2>/dev/null | head -n 1 | sed 's/go//')
    elif hash curl 2>/dev/null; then
        latest_version=$(curl -sL "https://go.dev/VERSION?m=text" 2>/dev/null | head -n 1 | sed 's/go//')
    fi

    # Validate version format
    if [[ "$latest_version" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
        echo "$latest_version"
    else
        echo ""
    fi
}

OS="$(uname -s)"
ARCH="$(uname -m)"

case $OS in
    "Linux")
        case $ARCH in
        "x86_64")
            ARCH=amd64
            ;;
        "aarch64")
            ARCH=arm64
            ;;
        "armv6" | "armv7l")
            ARCH=armv6l
            ;;
        "armv8")
            ARCH=arm64
            ;;
        "i686")
            ARCH=386
            ;;
        .*386.*)
            ARCH=386
            ;;
        esac
        PLATFORM="linux-$ARCH"
    ;;
    "Darwin")
          case $ARCH in
          "x86_64")
              ARCH=amd64
              ;;
          "arm64")
              ARCH=arm64
              ;;
          esac
        PLATFORM="darwin-$ARCH"
    ;;
esac

print_help() {
    echo "Usage: bash goinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  --remove\tRemove currently installed version"
    echo -e "  --version\tSpecify a version number to install"
}

if [ -z "$PLATFORM" ]; then
    echo "Your operating system is not supported by the script."
    exit 1
fi

if [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
    shell_profile="$HOME/.zshrc"
elif [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
    shell_profile="$HOME/.bashrc"
elif [ -n "$($SHELL -c 'echo $FISH_VERSION')" ]; then
    shell="fish"
    if [ -d "$XDG_CONFIG_HOME" ]; then
        shell_profile="$XDG_CONFIG_HOME/fish/config.fish"
    else
        shell_profile="$HOME/.config/fish/config.fish"
    fi
fi

if [ "$1" == "--remove" ]; then
    rm -rf "$GOROOT"
    if [ "$OS" == "Darwin" ]; then
        if [ "$shell" == "fish" ]; then
            sed -i "" '/# GoLang/d' "$shell_profile"
            sed -i "" '/set GOROOT/d' "$shell_profile"
            sed -i "" '/set GOPATH/d' "$shell_profile"
            sed -i "" '/set PATH $GOPATH\/bin $GOROOT\/bin $PATH/d' "$shell_profile"
        else
            sed -i "" '/# GoLang/d' "$shell_profile"
            sed -i "" '/export GOROOT/d' "$shell_profile"
            sed -i "" '/$GOROOT\/bin/d' "$shell_profile"
            sed -i "" '/export GOPATH/d' "$shell_profile"
            sed -i "" '/$GOPATH\/bin/d' "$shell_profile"
        fi
    else
        if [ "$shell" == "fish" ]; then
            sed -i '/# GoLang/d' "$shell_profile"
            sed -i '/set GOROOT/d' "$shell_profile"
            sed -i '/set GOPATH/d' "$shell_profile"
            sed -i '/set PATH $GOPATH\/bin $GOROOT\/bin $PATH/d' "$shell_profile"
        else
            sed -i '/# GoLang/d' "$shell_profile"
            sed -i '/export GOROOT/d' "$shell_profile"
            sed -i '/$GOROOT\/bin/d' "$shell_profile"
            sed -i '/export GOPATH/d' "$shell_profile"
            sed -i '/$GOPATH\/bin/d' "$shell_profile"
        fi
    fi
    echo "Go removed."
    exit 0
elif [ "$1" == "--help" ]; then
    print_help
    exit 0
elif [ "$1" == "--version" ]; then
    if [ -z "$2" ]; then # Check if --version has a second positional parameter
        echo "Please provide a version number for: $1"
    else
        VERSION=$2
    fi
elif [ ! -z "$1" ]; then
    echo "Unrecognized option: $1"
    exit 1
fi

# Auto-detect latest version if --version was not specified
if [ "$VERSION" == "$FALLBACK_VERSION" ]; then
    echo "Detecting latest Go version..."
    DETECTED_VERSION=$(get_latest_version)
    if [ -n "$DETECTED_VERSION" ]; then
        VERSION="$DETECTED_VERSION"
        echo "Latest version detected: $VERSION"
    else
        echo "Could not detect latest version, using fallback: $VERSION"
    fi
fi

if [ -d "$GOROOT" ]; then
    echo "The Go install directory ($GOROOT) already exists. Exiting."
    exit 1
fi

PACKAGE_NAME="go$VERSION.$PLATFORM.tar.gz"
TEMP_DIRECTORY=$(mktemp -d)

echo "Downloading $PACKAGE_NAME ..."
if hash wget 2>/dev/null; then
    wget https://dl.google.com/go/$PACKAGE_NAME -O "$TEMP_DIRECTORY/go.tar.gz"
else
    curl -o "$TEMP_DIRECTORY/go.tar.gz" https://dl.google.com/go/$PACKAGE_NAME
fi

if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Extracting File..."
mkdir -p "$GOROOT"

tar -C "$GOROOT" --strip-components=1 -xzf "$TEMP_DIRECTORY/go.tar.gz"

echo "Configuring shell profile in: $shell_profile"
touch "$shell_profile"
if [ "$shell" == "fish" ]; then
    {
        echo -e '\n# GoLang'
        echo "set GOROOT '${GOROOT}'"
        echo "set GOPATH '$GOPATH'"
        echo 'set PATH $GOPATH/bin $GOROOT/bin $PATH'
    } >> "$shell_profile"
else
    {
        echo -e '\n# GoLang'
        echo "export GOROOT=${GOROOT}"
        echo 'export PATH=$GOROOT/bin:$PATH'
        echo "export GOPATH=$GOPATH"
        echo 'export PATH=$GOPATH/bin:$PATH'
    } >> "$shell_profile"
fi

mkdir -p "${GOPATH}/"{src,pkg,bin}
echo -e "\nGo $VERSION was installed into $GOROOT.\nMake sure to relogin into your shell or run:"
echo -e "\n\tsource $shell_profile\n\nto update your environment variables."
echo "Tip: Opening a new terminal window usually just works. :)"
rm -f "$TEMP_DIRECTORY/go.tar.gz"
