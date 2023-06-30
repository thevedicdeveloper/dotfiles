#!/bin/sh

# Install git and bash using apk
apk add --no-cache git bash

# Create the bin directory if it doesn't exist
mkdir -p bin

# Copy git and bash to the bin directory
cp /usr/bin/git bin/
cp /bin/bash bin/

# Export the path to .bashprofile
echo 'export PATH="$PATH:'$(pwd)'/bin"' >> ~/.bashprofile

# Start a new interactive bash shell using .bashprofile as the initialization file
exec bash --rcfile ~/.bashprofile