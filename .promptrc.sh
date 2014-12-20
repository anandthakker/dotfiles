# enable coloring
export CLICOLOR=1

# set coloring scheme for black bg
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# for non black:
# export LSCOLORS=ExFxCxDxBxegedabagacad



# Define colors
# adapted by Scott Lessans from https://gist.github.com/skizzybiz/3789296
#
RESET='\[\033[00m\]'
FGBK='\[\033[0;30m\]' # foreground black
FGRD='\[\033[0;31m\]' # foreground red
FGGN='\[\033[0;32m\]' # foreground green
FGYL='\[\033[0;33m\]' # foreground yellow
FGBL='\[\033[0;34m\]' # foreground blue
FGMG='\[\033[0;35m\]' # foreground magenta
FGCY='\[\033[0;36m\]' # foreground cyan
FGGR='\[\033[0;37m\]' # foreground gray
FGBKBD='\[\033[1;30m\]' # foreground black bright
FGRDBD='\[\033[1;31m\]' # foreground red bright
FGGNBD='\[\033[1;32m\]' # foreground green bright
FGYLBD='\[\033[1;33m\]' # foreground yellow bright
FGBLBD='\[\033[1;34m\]' # foreground blue bright
FGMGBD='\[\033[1;35m\]' # foreground magenta bright
FGCYBD='\[\033[1;36m\]' # foreground cyan bright
FGGRBD='\[\033[1;37m\]' # foreground gray bright
BGBK='\[\033[40m\]' # background black
BGRD='\[\033[41m\]' # background red
BGGN='\[\033[42m\]' # background green
BGYL='\[\033[43m\]' # background yellow
BGBL='\[\033[44m\]' # background blue
BGMG='\[\033[45m\]' # background magenta
BGCY='\[\033[46m\]' # background cyan
BGGR='\[\033[47m\]' # background gray

# Give the hostname an emphasized color
HOSTCOLOR="$FGGRBD"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state=$FGGNBD
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state=$FGYLBD
  else
    state=$FGRDBD
  fi

  if [[ ${git_status} =~ "Changes not staged for commit:" ]]; then
      dirty=" *"
  else
      dirty=""
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then

    direction=${BASH_REMATCH[1]}

    amnt_pattern="Your branch is $direction of (.*) by ([0-9]*)"
    if [[ ${git_status} =~ ${amnt_pattern} ]]; then
        amnt=" ${BASH_REMATCH[2]}"
    else
        amnt=""
    fi


    if [[ "$direction" == "ahead" ]]; then
      remote="(↑$amnt)"
    else
      remote="(↓$amnt)"
    fi
  else
    remote=""
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # Set the final branch string.
  BRANCH="${state}[${branch}${dirty}]${remote}$RESET"
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  # echo "set_prompt_symbol"
  if test $1 -eq 0 ; then
    PROMPT_SYMBOL="⌘"
  else
    PROMPT_SYMBOL="\[\033[0;31m\]⌘\[\033[0m\]"
  fi
}

# show when execution in python virtual env
function set_virtual_env () {

    if [ -n "$VIRTUAL_ENV" ] ; then
        VENV="[`basename $VIRTUAL_ENV`]"
    else
        VENV=""
    fi

}

# Set the full bash prompt.
function set_bash_prompt () {
  # echo "set_bash_prompt"
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  set_virtual_env

  # Fill spaces between the left and right halves
  strippedbranch=`echo $BRANCH | sed 's|\\\\\\[[^]]*\\]||g'`
  lefthalf="$VENV[`whoami`:`pwd | sed "s|$HOME|~|"`]"
  righthalf="$strippedbranch"
  let fillsize=${COLUMNS}-${#lefthalf}-${#righthalf}-1
  if [ "$fillsize" -gt "0" ]; then
      fill=`printf ' %.0s' {1..300}` # 300 spaces
      fill=${fill:0:$fillsize}
  else
      fill=" "
  fi

  # Set the bash prompt variable.
  PS1="\n${FGBLBD}${VENV}${RESET}[$FGGNBD\u:$RESET$FGGR\w]$fill$RESET ${BRANCH}$RESET\n${PROMPT_SYMBOL}  "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
