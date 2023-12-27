#!/bin/sh
# Install the prereqs - https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
sudo apt-get install ninja-build gettext cmake unzip curl
echo "Downloading latest stable release..."
curl -s -L https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz > ~/nvim-src.tar.gz
echo "Extracting archive..."
mkdir ~/nvim-src
tar -xzf ~/nvim-src.tar.gz -C ~/nvim-src
cd ~/nvim-src/neovim-stable
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
echo "Cleaning up..."
rm ~/nvim-src.tar.gz
rm -rf ~/nvim-src
export PATH="$PATH:$HOME/neovim/bin"
NVIM_VER=`nvim --version | grep 'NVIM'`
echo "Installed ${NVIM_VER}!"
echo "Run to add to path:"
echo "export PATH=\"\$HOME/neovim/bin:\$PATH\""
