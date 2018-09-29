#vim-config install

#install ctags
sudo apt-get install -y ctags
#install cscope
sudo apt-get install -y cscope
sudo apt-get install -y cmake git
sudo apt-get install -y python-dev
#install vim8
if [ ! -d ~/.vim8-source ]; then
    mkdir ~/.vim8-source
fi
cd  ~/.vim8-source
echo "git clone vim8"
git clone https://github.com/vim/vim.git .
./configure --enable-multibyte --enable-python3interp=yes --enable-pythoninterp=yes   --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/  --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu/
sudo make && sudo make install
sudo ln -s -f /usr/local/bin/vim  /usr/bin/vim 
sudo ln -s -f /usr/local/bin/vim  /usr/bin/vi 

ln -s -f ~/.vim-yu/vimrc ~/.vimrc

if [ ! -d ~/.vim/bundle ]; then
    mkdir ~/.vim/bundle
fi
cd ~/.vim/bundle
#get YouCompleteMe
git clone https://github.com/Valloric/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer

#install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "install vim vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
#install plugin
echo "install vim plugin"
vim -c "source $MYVIMRC" -c "q"
vim -c "PluginInstall" -c "q" -c "q"

if [ -f ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ]; then
	if [ ! -d ~/.vim/colors ]; then
		mkdir ~/.vim/colors -p
	fi
	cp ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
fi

if [ "`grep -c "bashrc-local"  ~/.bashrc`" -eq '0' ]; then
    #echo "not found bashrc-logcal"
    echo "if [ -f ~/.bashrc-local ]; then" >> ~/.bashrc
    echo "\t. ~/.bashrc-local" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi

#install tmux
sudo apt-get install tmux
ln -s -f ~/.vim-yu/tmux.conf ~/.tmux.conf

echo "install over!"
