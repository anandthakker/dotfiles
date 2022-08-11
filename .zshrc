if command -v brew > /dev/null 2>&1; then
  MACOSX=1
fi

export HOMEBREW_BUNDLE_FILE="$HOME"/dotfiles/Brewfile

export EDITOR='vim'
if command -v nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR='nvim'
fi
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

PATH="$HOME/dotfiles/bin:$HOME/bin:$PATH"

#
# Oh My Zsh
#

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="one"
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM="$HOME"/dotfiles/zsh-custom
plugins=(git nvm github zsh-syntax-highlighting zsh-autosuggestions zsh-completions aws)
source $ZSH/oh-my-zsh.sh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# allow bash completions https://stackoverflow.com/a/67161186
autoload -Uz compinit bashcompinit
compinit
bashcompinit

#
# Utilities
#

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# https://github.com/juliangruber/project.sh
[ -d $HOME/dotfiles/project.sh ] && source $HOME/dotfiles/project.sh/project.sh
export PROJ_ROOT=$HOME/c
mkdir -p $PROJ_ROOT

# Docker helpers
[ -f $HOME/dotfiles/.dockerfunc ] && source $HOME/dotfiles/.dockerfunc

# bun
export BUN_INSTALL="/$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# homebrew sbin (for dnsmasq)
PATH="/usr/local/sbin:${PATH}"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
export PATH=$(pyenv root)/shims:$PATH

# fix puppeteer install (https://linguinecode.com/post/how-to-fix-m1-mac-puppeteer-chromium-arm64-bug)
if [[ $(uname -m) == 'arm64' ]]; then
  export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
  export PUPPETEER_EXECUTABLE_PATH=`which chromium`
fi

#
# Aliases
#

if [ MACOSX -o -x /usr/bin/dircolors ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias timeout='gtimeout'

alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"

#
# Startup
#

# start tmux
ta || true

