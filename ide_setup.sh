mkdir software
mkdir bin
cd software 
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
ln -s ~/software/nvim-linux64/bin/nvim ~/bin/nvim
cd ..
git clone https://github.com/omarjamil/ide_config.git
cd ide_config
./install.sh


