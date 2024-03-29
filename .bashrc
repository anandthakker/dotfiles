if command -v brew > /dev/null 2>&1; then
  MACOSX=1
fi

################################################################################
# History
################################################################################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

################################################################################
# Window
################################################################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

################################################################################
# Aliases
################################################################################

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
fi

if [ MACOSX -o -x /usr/bin/dircolors ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

alias timeout='gtimeout'

################################################################################
# Colors
################################################################################

# Base16 Shell
BASE16_SHELL="$HOME/dotfiles/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

################################################################################
# Misc
################################################################################

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# custom prompt
if [ -f ~/.promptrc.sh ]; then
  source ~/.promptrc.sh
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ $MACOSX ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# editor
export EDITOR='vim'
if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
  export EDITOR='nvim'
fi
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# https://github.com/juliangruber/project.sh
[ -d $HOME/dotfiles/project.sh ] && source $HOME/dotfiles/project.sh/project.sh
export PROJ_ROOT=$HOME/c
mkdir -p $PROJ_ROOT

# Docker helpers
[ -f $HOME/dotfiles/.dockerfunc ] && source $HOME/dotfiles/.dockerfunc

# Android development
export ANDROID_HOME=/Users/anand/Library/Android/sdk

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

################################################################################
# Path
################################################################################
PATH="$HOME/dotfiles/bin:$HOME/bin:$PATH:$HOME/.rvm/bin"

PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="/usr/local/opt/qt5/bin:${PATH}"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# use GNU sed instead of BSD sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"

################################################################################
# The End
################################################################################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
