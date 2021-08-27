# Based on Dracula Theme v1.2.5
#
# https://github.com/dracula/dracula-theme

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

ZSH_THEME_VIRTUALENV_PREFIX=" ("
ZSH_THEME_VIRTUALENV_SUFFIX=")"

ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✔️ "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}%{$fg_bold[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# Relies on patched powerline font for the "branch" symbol
# https://github.com/powerline/fonts
PROMPT='${ret_status}%{$fg_bold[white]%}$(virtualenv_prompt_info)%p %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$reset_color%}'
