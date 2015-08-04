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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

################################################################################
# Colors
################################################################################

# Base16 Shell
BASE16_SHELL="$HOME/dotfiles/base16-shell/base16-atelierdune.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

################################################################################
# Misc
################################################################################

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

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
VISUAL='vim'
EDITOR='vim'
# use mvim -v for vim in the terminal
[ $MACOSX ] && alias vim='mvim -v' && EDITOR='mvim -v'

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

################################################################################
# Path
################################################################################
PATH="$HOME/dotfiles/bin:$HOME/bin:$PATH:$HOME/.rvm/bin"

################################################################################
# The End
################################################################################
