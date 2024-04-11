# the argument needs to be the path to the home area
cd $1
echo "dev-container" >> .name
mkdir software
mkdir bin
cd software 
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
ln -s $1/software/nvim-linux64/bin/nvim $1/bin/nvim
cd ..
git clone https://github.com/omarjamil/ide_config.git
cd ide_config
./install.sh $1


