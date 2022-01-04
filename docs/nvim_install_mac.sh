# This script is used to update Nvim on macOS
#!/bin/bash
set -eux

wget https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz

if [[ ! -d "$HOME/tools/"  ]]; then
    mkdir -p "$HOME/tools"
fi

# Delete existing nvim installation.
if [[ -d "$HOME/tools/nvim-osx64" ]]; then
    rm -rf "$HOME/tools/nvim-osx64"
fi

# Extract the tar ball
tar zxvf nvim-macos.tar.gz -C "$HOME/tools"

rm nvim-macos.tar.gz
