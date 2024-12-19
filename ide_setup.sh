cd $HOME
mkdir software
mkdir bin
cd software 
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
ln -s $1/software/nvim-linux64/bin/nvim $1/bin/nvim

git clone -b main --single-branch https://github.com/omarjamil/ide_config.git
echo "Follow ide config setup and add neovim to the PATH"

