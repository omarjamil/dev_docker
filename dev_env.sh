git clone -b master --single-branch --depth 1 https://github.com/neovim/neovim.git

cd neovim
make CMAKE_BUILD_TYPE=Release
rm -r build/  # clear the CMake cache
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install

cd $HOME 
mkdir $HOME/bin
ln -s $HOME/neovim/bin/nvim $HOME/bin/nvim

git clone -b main --single-branch https://github.com/omarjamil/ide_config.git
echo "Follow ide config setup and add neovim to the PATH"

