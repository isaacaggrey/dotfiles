if [[ -z $TMUX ]]; then
    PATH=$HOME/.bin:$PATH
fi

PATH="$HOME/.dynamic-colors/bin:$PATH"
PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

# inspired by:
# http://stackoverflow.com/questions/13058578/how-to-prevent-tmux-from-filling-up-the-global-path-variable-with-duplicated-pat

export MOZCONFIG="$HOME/.mozconfig"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH
