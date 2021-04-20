# comments on command-line
setopt interactivecomments
## interaction
setopt extended_glob

# select first match in menu
setopt menu_complete

# highlight possible matches
zstyle ':completion:*' menu select

# semi case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

## changing directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt pushdsilent

## history management
setopt hist_find_no_dups
setopt histignoredups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt no_beep
setopt share_history
setopt noclobber

HISTSIZE=100000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=100000
