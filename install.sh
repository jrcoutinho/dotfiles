#!/bin/sh
echo "Setting up your Mac..."

##### Variables
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc vimrc"               # list of files/folders to symlink in homedir
numsteps=6
currentstep=1

##### Install Xcode cli
echo "Step $currentstep/$numsteps: Install Xcode"
((currentstep++))

if test $(xcode-select -p); then
    echo 'Xcode is already installed'
else
    xcode-select --install
fi

##### Check for Homebrew and install it if not found
echo "Step $currentstep/$numsteps: Install Homebrew and dependencies listed in the Brewfile"
((currentstep++))

if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/f2a764ef944b1080be64bd88dca9a1d80130c558/Formula/python.rb
brew bundle

##### Install Python dependencies
echo "Step $currentstep/$numsteps: Install python dependencies"
((currentstep++))

pip3 install -r $dir/requirements.txt

#### Install Powerlevel9k & fonts
echo "Step $currentstep/$numsteps: Install Powerlevel9k and powerline fonts"
((currentstep++))

if [ -d ~/powerlevel9k ]; then
    echo 'Powerlevel9k is already installed'
else
    git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi

##### Create symlinks
echo "Step $currentstep/$numsteps: Create symlinks to the repo's dotfiles"
((currentstep++))

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# symlink kitty config file
echo "Create symlink for kitty config file"
ln -Fs $dir/kitty.conf ~/.config/kitty/kitty.conf

##### Configure vim
mkdir -p ~/.vim/tmp # backup files
mkdir ~/.vim/bundle # plugins

##### Set zsh as default shell
echo "Step $currentstep/$numsteps: Setting zsh as default shell"
((currentstep++))

if [ $SHELL = $(which zsh) ]; then
    echo 'zsh is already the default shell!'
else
    echo "$(which zsh)" | sudo tee -a /etc/shells
    chsh -s $(which zsh)
fi

