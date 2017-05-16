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

# aliases
alias vi='vim'
alias srczsh='source ~/.zshrc'
alias ff='setfont ter-132n'
PS1="%n@%m:%~/ $ "

# trying out history-substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# For Haskell
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

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

# tab completion for PIDs
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm,command -w -w"
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# zsh completions chache
CACHEDIR="$HOME/.zsh/cache"

# create $CACHEDIR if it does not exist
if [ ! -d $CACHEDIR ]; then
  mkdir -p $CACHEDIR
fi

# cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $CACHEDIR

# load completions
autoload -U compinit
compinit -d $CACHEDIR/zcompdump

# If a pattern for filename generation has no matches, print an error,
# instead of leaving it unchanged in the argument list. This also
# applies to file expansion of an initial ~ or =.
unsetopt nomatch

# Vi-mode
bindkey -v

# alt + arrows
#bindkey '[D' backward-word
#bindkey '[C' forward-word
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word

# ctrl + arrows
bindkey '^[Od' backward-word
bindkey '^[Oc' forward-word
#bindkey '^[[1;5d' backward-word
#bindkey '^[[1;5c' forward-word

# home / end
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line

# delete
bindkey '^[[3~' delete-char

# page up / page down
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward

# shift + tab
bindkey '^[[Z' reverse-menu-complete

# VI MODE KEYBINDINGS (ins mode)
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins -s '^b' "←\n" # C-b move to previous directory (in history)
bindkey -M viins -s '^f' "→\n" # C-f move to next directory (in history)
bindkey -M viins '^k'    kill-line
bindkey -M viins '^r'    history-incremental-pattern-search-backward
bindkey -M viins '^s'    history-incremental-pattern-search-forward
bindkey -M viins '^o'    history-beginning-search-backward
bindkey -M viins '^p'    history-beginning-search-backward
bindkey -M viins '^n'    history-beginning-search-forward
bindkey -M viins '^y'    yank
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
bindkey -M viins '^h'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^_'    undo
bindkey -M viins '^x^l'  history-beginning-search-backward-then-append
bindkey -M viins '^x^r'  redisplay
bindkey -M viins '^[OH'  beginning-of-line # Home
bindkey -M viins '^[OF'  end-of-line       # End
bindkey -M viins '^[[2~' overwrite-mode    # Insert


# VI MODE KEYBINDINGS (cmd mode)
bindkey -M vicmd 'ca'    change-around
bindkey -M vicmd 'ci'    change-in
bindkey -M vicmd 'da'    delete-around
bindkey -M vicmd 'di'    delete-in
bindkey -M vicmd 'ga'    what-cursor-position
bindkey -M vicmd 'gg'    beginning-of-history
bindkey -M vicmd 'G '    end-of-history
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^k'    kill-line
bindkey -M vicmd '^r'    history-incremental-pattern-search-backward
bindkey -M vicmd '^s'    history-incremental-pattern-search-forward
bindkey -M vicmd '^o'    history-beginning-search-backward
bindkey -M vicmd '^p'    history-beginning-search-backward
bindkey -M vicmd '^n'    history-beginning-search-forward
bindkey -M vicmd '^y'    yank
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '^[f'   forward-word                      # Alt-f
bindkey -M vicmd '^[b'   backward-word                     # Alt-b
bindkey -M vicmd '^[d'   kill-word                         # Alt-d
bindkey -M vicmd '^[[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '^[[6~' history-beginning-search-forward  # PageDown
bindkey -M vicmd '^[OH'  beginning-of-line # Home
bindkey -M vicmd '^[OF'  end-of-line       # End

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

## Clipboard
#[[ -n $DISPLAY ]] && (( $+commands[xclip] )) && {
#
#  function cutbuffer() {
#    zle .$WIDGET
#    echo $CUTBUFFER | xclip
#  }
#
#  zle_cut_widgets=(
#    vi-backward-delete-char
#    vi-change
#    vi-change-eol
#    vi-change-whole-line
#    vi-delete
#    vi-delete-char
#    vi-kill-eol
#    vi-substitute
#    vi-yank
#    vi-yank-eol
#  )
#  for widget in $zle_cut_widgets
#  do
#    zle -N $widget cutbuffer
#  done
#
#  function putbuffer() {
#    zle copy-region-as-kill "$(xclip -o)"
#    zle .$WIDGET
#  }
#
#  zle_put_widgets=(
#    vi-put-after
#    vi-put-before
#  )
#  for widget in $zle_put_widgets
#  do
#    zle -N $widget putbuffer
#  done
#}

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

## Fancy ctrl+z
#function fancy-ctrl-z () {
#  if [[ $#BUFFER -eq 0 ]]; then
#    fg
#    zle redisplay
#  else
#    zle push-input
#    zle clear-screen
#  fi
#}
#zle -N fancy-ctrl-z
#bindkey '^Z' fancy-ctrl-z

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# display CPU usage stats for commands taking more than 10 seconds
REPORTTIME=10
