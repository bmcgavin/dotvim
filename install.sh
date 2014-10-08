#!/bin/bash

cp -R .vim* ~/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Launch vim and run :BundleInstall"
read -p "Press enter to continue to building plugins"
cd ~/.vim
cd ruby/command-t/
ruby extconf.rb
make
cd ~/.vim
cd bundle/YouCompleteMe
./install.sh