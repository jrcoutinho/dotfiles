# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/$USER/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

# virtualenvwrapper configurations
VIRTUALENVWRAPPER_PYTHON=$(which python3)
source /usr/local/bin/virtualenvwrapper.sh

# powerline configuration
source  ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv)
DEFAULT_USER=julio
