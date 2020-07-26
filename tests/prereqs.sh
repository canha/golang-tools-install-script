#!/bin/bash
set -e

OS="$(uname -s)"

if ! command -v fish &> /dev/null
then
    case $OS in
        "Linux")
            apt-get install -y fish
        ;;
        "Darwin")
            brew install fish
        ;;
    esac
fi
