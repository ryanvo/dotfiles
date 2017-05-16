#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Start ssh-agent
eval $(keychain --nogui --eval --quiet id_rsa ~/.ssh/id_rsa)

# The Fuck
eval $(thefuck --alias f)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Terminix
if [ $TERMINIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# Set var for Dropbox
if [ -n "$DISPLAY" ]; then
    export BROWSER=chromium
else 
    export BROWSER=links
fi

# general
# set ignoreeof

# make cd push the old directory onto the directory stack
setopt auto_pushd

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt notify

# Turn off terminal driver flow control (CTRL+S/CTRL+Q)
setopt noflowcontrol
stty -ixon -ixoff

# Do not kill background processes when closing the shell.
setopt nohup

# ignore certain cmds in history
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:* --help"

# multiple zsh sessions will append to the same history file (incrementally, after each command is executed)
setopt inc_append_history

# purge duplicates first
setopt hist_expire_dups_first

# if a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt hist_ignore_all_dups

# reduce unnecessary blanks from commands being written to history
setopt hist_reduce_blanks

# import new commands from history (mostly)
setopt share_history

# parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt prompt_subst

# If a pattern for filename generation has no matches, print an error,
# instead of leaving it unchanged in the argument list. This also
# applies to file expansion of an initial ~ or =.
unsetopt nomatch

# Prompt changes to indicate vi mode
PS1="%n@%m:%~/ $ "

precmd() {
  RPROMPT=""
}
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="- - VI - -"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

export KEYTIMEOUT=20


#
# Misc
#

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# display CPU usage stats for commands taking more than 10 seconds
REPORTTIME=10
