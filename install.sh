#!/bin/sh
echo "Setting up your Mac..."

##### Variables
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc vimrc"               # list of files/folders to symlink in homedir
numsteps=5

##### Install Xcode cli
echo "Step 1/$numsteps: Install Xcode"
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

##### Install Python dependencies
echo "Step 3/$numsteps: Install python dependencies"
pip3 install -r $dir/requirements.txt

#### Install Powerlevel9k & fonts
echo "Step 4/$numsteps: Install Powerlevel9k and powerline fonts"
git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

##### Create symlinks
echo "Step 5/$numsteps: Create symlinks to the repo's dotfiles"

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

##### Set zsh as default shell
echo "Step 6/$numsteps: Set zsh as default shell"
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)
