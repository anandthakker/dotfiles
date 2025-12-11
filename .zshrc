if command -v brew > /dev/null 2>&1; then
  MACOSX=1
fi

export HOMEBREW_BUNDLE_FILE="$HOME"/dotfiles/Brewfile

PATH="$HOME/dotfiles/bin:$HOME/bin:$PATH"
setopt autocd

source $HOME/dotfiles/.zsh_prompt

# Editor
export EDITOR='vim'
if command -v nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR='nvim'
fi
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

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

# completions, including bash completions https://stackoverflow.com/a/67161186
autoload -Uz compinit bashcompinit
compinit
bashcompinit

#
# Utilities
#

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'
source <(fzf --zsh)

# https://github.com/juliangruber/project.sh
[ -d $HOME/dotfiles/project.sh ] && source $HOME/dotfiles/project.sh/project.sh
export PROJ_ROOT=$HOME/c
mkdir -p $PROJ_ROOT

# Docker helpers
[ -f $HOME/dotfiles/.dockerfunc ] && source $HOME/dotfiles/.dockerfunc

# rust
PATH="$HOME/.cargo/bin:$PATH"
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#
# Aliases
#
if [ MACOSX -o -x /usr/bin/dircolors ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias timeout='gtimeout'

# bun completions
[ -s "/Users/anand/.bun/_bun" ] && source "/Users/anand/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ai-sandbox
[ -f "$HOME/dotfiles/ai-sandbox/ai-sandbox.zsh" ] && source "$HOME/dotfiles/ai-sandbox/ai-sandbox.zsh"

# Machine-specific overrides (not in version control)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
