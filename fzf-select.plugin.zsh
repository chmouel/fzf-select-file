# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

# do nothing if exa is not installed
(( ! $+commands[exa] )) && return

(( ! ${+ZSH_FZF_SELECT_FZF_ARGS} )) && typeset -g ZSH_FZF_SELECT_FZF_ARGS='--ansi -1 --tac +s -m -x -e --preview-window=hidden'
(( ! ${+ZSH_FZF_SELECT_EXA_ARGS} )) && typeset -g ZSH_FZF_SELECT_EXA_ARGS='--color=always -l --sort=newest'
(( ! ${+ZSH_FZF_SELECT_BIND} )) && typeset -g ZSH_FZF_SELECT_BIND='^x^f'

__fzf_select() {
    local exa_extras=$@
    local choices=(${(f)"$(exa ${=exa_extras} ${=ZSH_FZF_SELECT_EXA_ARGS} .|fzf ${=ZSH_FZF_SELECT_FZF_ARGS})"})
    (( ${#choices} )) || return 1
    BUFFER+=" ${(@q)${choices[@]/(#m)*/${${(As: :)MATCH}[7,-1]}}}"
    zle end-of-line
    return 0
}

fzf_select() {
    __fzf_select
    return $?
}

fzf_select_all() {
    __fzf_select -a
    return $?
}

autoload fzf_select; zle -N fzf_select
autoload fzf_select_all; zle -N fzf_select_all

bindkey $ZSH_FZF_SELECT_BIND fzf_select
