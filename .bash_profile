
PATH="$HOME/bin:/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

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

# remap vim to MacVim
alias vim='mvim -v'
