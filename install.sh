#!/bin/sh
echo "Setting up your Mac..."

##### Variables
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc vimrc"               # list of files/folders to symlink in homedir
numsteps=4

##### Install Xcode cli
echo "Step 1/$numsteps): Install Xcode"
xcode-select --install

##### Check for Homebrew and install it if it is not found
echo "Step 2/$numsteps: Install Homebrew and dependencies listed in the Brewfile"
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update
brew upgrade

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

##### Create symlinks
echo "Step 3/$numsteps: Create symlinks to the repo's dotfiles"

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

# Set zsh as default shell
echo "Step 4/$numsteps: Set zsh as default shell"
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)
