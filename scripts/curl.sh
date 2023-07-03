#!/bin/sh

echo "====================================="
echo "INSTALLING CURL..."
echo "====================================="
apk add curl
echo "====================================="
echo "CURL INSTALLED."
echo "====================================="
echo "CURL VERSION: $(curl --version)"
echo "====================================="