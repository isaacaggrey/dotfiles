import XMonad

main = xmonad defaultConfig
    { terminal           = "urxvt -e $SHELL -c \"tmux -q has-session \
                           \ && exec tmux attach-session -d \
                           \ || exec tmux new-session -n$USER -s$USER@$HOSTNAME\""
    , borderWidth        = 2
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00"
    }
