#!/bin/bash

# Determine the operating system
os=$(uname -s)

# Set the path to the yaml file based on the operating system
if [ "$os" == "Darwin" ]; then
    yaml_file="macos.yaml"
elif [ "$os" == "Linux" ]; then
    # Check for specific Linux distributions
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" == "alpine" ]; then
            yaml_file="alpine.yaml"
        elif [ "$ID" == "ubuntu" ]; then
            yaml_file="ubuntu.yaml"
        fi
    fi
fi

# Load the yaml file and print it to verify
yaml=$(cat "script/$yaml_file")
echo "$yaml"

# Parse the yaml file and install the tools
while read -r line; do
    if [[ $line =~ ^name ]]; then
        tool_name=$(echo $line | cut -d':' -f2 | xargs)
    elif [[ $line =~ ^install ]]; then
        install=$(echo $line | cut -d':' -f2 | xargs)
        if [ "$install" == "true" ]; then
            read -p "Do you want to install $tool_name? (y/n) " answer
            if [ "$answer" == "" ] || [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
                echo "Installing $tool_name..."
                # Install the tool here, e.g. using homebrew on macOS:
                if [ "$os" == "Darwin" ]; then
                    brew install $tool_name
                fi

                # Create the bin directory if it doesn't exist and copy the tool there
                mkdir -p bin
                cp "/usr/local/bin/$tool_name" bin/

                # Export the path to .bash_profile and update bash to use it as the profile
                echo 'export PATH="$PATH:'$(pwd)'/bin"' >> ~/.bash_profile
                source ~/.bash_profile
            fi
        fi
    fi
done <<< "$yaml"