# vim-like zsh
bindkey -v
bindkey '^[[5D' vi-backward-word
bindkey '^[[5C' vi-forward-word
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line
bindkey "jj" vi-cmd-mode
bindkey -M vicmd "u" undo
bindkey -M vicmd "^R" redo
bindkey -M viins "^Z" undo
bindkey -M viins "^R" undo
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey '^[[Z' reverse-menu-complete

# zkbd source: http://zshwiki.org/home/zle/bindkeys
autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Backspace]}"  ]]  && bindkey  "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char

# http://www.zsh.org/mla/workers/2010/msg00861.html
    function _-vi-ctrl-o
    {
        emulate -LR zsh
        local keystr
        read -k keystr
        local -r keystr
        local -ri key=$(( #keystr ))
          if (( key==##A )) ; then zle end-of-line
        elif (( key==##$ )) ; then zle end-of-line
        elif (( key==##I )) ; then zle vi-first-non-blank
        elif (( key==##d )) ; then _-vi-delete
        elif (( key==##0 )) && [[ -z $NUMERIC ]] ;
                              then zle beginning-of-line
        elif (( key>=##0 && key<=##9 ))
                              then _-vi-digit-arg $(( key - ##0 )) _-vi-ctrl-o
        #elif (( key==##s )) ; then zle sedsubstitute
        #elif (( key==##= )) ; then zle tailfor
        else
            zle ${${(z)$(bindkey -M vicmd $keystr)}[2]}
        fi
    }

    zle -N vi-ctrl-o                         _-vi-ctrl-o

    bindkey -M viins "^o" "vi-ctrl-o"

    # Source: https://bbs.archlinux.org/viewtopic.php?id=95078
zle-keymap-select () {
    if [ $TERM != "linux" ]; then
        if [ $KEYMAP = vicmd ]; then
            echo -ne "\033]12;Red\007"
        else
            echo -ne "\033]12;Grey\007"
        fi
    fi
}
zle -N zle-keymap-select
zle-line-init () {
    zle -K viins
    if [ $TERM != "linux" ]; then
        echo -ne "\033]12;Grey\007"
    fi
}
zle -N zle-line-init
