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

ln -s -f ~/.vim-yu/vimrc ~/.vimrc


#get YouCompleteMe
if [ ! -d ~/.vim/bundle ]; then
    mkdir ~/.vim/bundle
fi
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer

#install plugin
echo "install vim plugin"
vim -c "PluginInstall" -c "q" -c "q"

echo "install over!"
