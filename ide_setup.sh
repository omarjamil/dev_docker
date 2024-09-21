# the argument needs to be the path to the home area
cd $1
mkdir software
mkdir bin
cd software 
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
ln -s $1/software/nvim-linux64/bin/nvim $1/bin/nvim
