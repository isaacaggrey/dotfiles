if [[ -z $TMUX ]]; then
    PATH=$HOME/.bin:$PATH
    export PATH
fi

export PATH="$HOME/.dynamic-colors/bin:$PATH"

# inspired by:
# http://stackoverflow.com/questions/13058578/how-to-prevent-tmux-from-filling-up-the-global-path-variable-with-duplicated-pat

export MOZCONFIG="$HOME/.mozconfig"
