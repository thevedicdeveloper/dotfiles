#!/bin/sh

echo "====================================="
echo "INSTALLING GIT..."
echo "====================================="
apk add git
echo "====================================="
echo "GIT INSTALLED."
echo "====================================="
echo "GIT VERSION: $(git --version)"
echo "====================================="
echo "CONFIGURING GIT..."
echo "====================================="
git config --global include.path ../config/.gitconfig
echo "====================================="
echo "GIT CONFIG CONFIGURED..."
echo "====================================="