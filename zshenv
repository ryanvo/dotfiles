# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# For Haskell
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

export LESS='-R -F -X -n'

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
