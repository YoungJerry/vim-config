#vim-config install

#get the shell dir
basepath=$(cd `dirname $0`; pwd)

#install ctags
sudo apt-get install -y ctags
#install cscope
sudo apt-get install -y cscope
sudo apt-get install -y cmake git tig
sudo apt-get install -y python-dev python3-dev
sudo apt-get install -y libncurses5-dev
#install vim8
if [ ! -d ~/.vim8-source ]; then
    mkdir ~/.vim8-source
fi
#rm the older viminfo
sudo rm ~/.viminfo -rf
cd  ~/.vim8-source
echo "git clone vim8"
git clone https://github.com/vim/vim.git .
#./configure --enable-multibyte --enable-python3interp=yes --enable-pythoninterp=yes   --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/  --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/
./configure --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/
sudo make && sudo make install
sudo ln -s -f /usr/local/bin/vim  /usr/bin/vim 
sudo ln -s -f /usr/local/bin/vim  /usr/bin/vi 

ln -s -f $basepath/vimrc ~/.vimrc

if [ ! -d ~/.vim/colors ]; then
    mkdir ~/.vim/colors -p
fi
if [ ! -f ~/.vim/colors/solarized.vim ]; then
    cd ~/.vim/colors
    git clone https://github.com/altercation/vim-colors-solarized.git
    cp vim-colors-solarized/colors/solarized.vim .
    rm vim-colors-solarized/ -rf
fi

if [ ! -d ~/.vim/bundle ]; then
    mkdir ~/.vim/bundle -p
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

ln -s -f $basepath/bashrc-local ~/.bashrc-local
if [ "`grep -c "bashrc-local"  ~/.bashrc`" -eq '0' ]; then
    #echo "not found bashrc-logcal"
    echo "if [ -f ~/.bashrc-local ]; then" >> ~/.bashrc
    echo "\t. ~/.bashrc-local" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    source ~/.bashrc
fi

#install tmux
sudo apt-get install tmux
ln -s -f $basepath/tmux.conf ~/.tmux.conf

echo "install over!"
