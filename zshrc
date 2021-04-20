source ~/.zplug/init.zsh

zplug "~/.config/zsh", from:local, use:'*.zsh'

#######################################################################
# PROMPTS
#######################################################################

autoload -Uz colors compinit promptinit
colors
compinit
promptinit
prompt walters

#######################################################################
# ENVIRONMENT VARIABLES
#######################################################################

export EDITOR=vim # vim <3
export WORDCHARS='' # make backward-word and forward-word jump by word
export DISPLAY=':0.0'

#######################################################################
# FUNCTIONS
#######################################################################

function suspend() {
    print "Session is about to be suspended..."
    sudo pm-suspend && dm-tool lock
}

fasd_cache="$HOME/.fasd-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache"  ]; then
  fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

#######################################################################
# FILE SOURCES
#######################################################################

#eval `dircolors /etc/dir_colors` TODO: install via nix
#eval "$(hub alias -s)" TODO: install via nix

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh TODO: install via nix

# disable interrupt flow keybinding
stty -ixon

vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
zplug load --verbose

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/isaac/.sdkman"
#[[ -s "/home/isaac/.sdkman/bin/sdkman-init.sh" ]] && source "/home/isaac/.sdkman/bin/sdkman-init.sh"
