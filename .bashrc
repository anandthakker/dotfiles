
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# custom prompt
if [ -f ~/.promptrc.sh ]; then
  source ~/.promptrc.sh
fi

# completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# editor
alias vim='mvim -v'
EDITOR='mvim -v'

# added by travis gem
[ -f /Users/anand/.travis/travis.sh ] && source /Users/anand/.travis/travis.sh

# path
PATH="$HOME/dotfiles/bin:$HOME/bin:$PATH:$HOME/.rvm/bin"
