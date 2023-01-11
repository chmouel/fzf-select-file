# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

# do nothing if exa is not installed
(( ! $+commands[exa] )) && return

(( ! ${+ZSH_FZF_SELECT_FILE_FZF_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_ARGS='--ansi -1 --tac +s -m -x -e --preview-window=hidden'
(( ! ${+ZSH_FZF_SELECT_FILE_EXA_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_EXA_ARGS='--color=always -l --sort=newest'
(( ! ${+ZSH_FZF_SELECT_FILE_BIND} )) && typeset -g ZSH_FZF_SELECT_FILE_BIND='^x^f'

__fzf_select_file() {
    local exa_extras=$@
    local choices=(${(f)"$(exa ${=exa_extras} ${=ZSH_FZF_SELECT_FILE_EXA_ARGS} .|fzf ${=ZSH_FZF_SELECT_FILE_FZF_ARGS})"})
    local space=""
    local goend=
    (( ${#choices} )) || return 1
    [[ -n ${BUFFER} && "$BUFFER" != *" " ]] && space=" "
    if [[ -n ${BUFFER} ]];then
        goend=1
    else
        space=" "
    fi
    BUFFER+="${space}${(@q)${${choices[@]/(#m)*/${${(As: :)MATCH}[7,-1]}}}%% ->*}"
    (( goend )) && zle end-of-line
    return 0
}

fzf_select_file() {
    __fzf_select_file
    return $?
}

fzf_select_file_all() {
    __fzf_select_file -a
    return $?
}

autoload fzf_select_file; zle -N fzf_select_file
autoload fzf_select_file_all; zle -N fzf_select_file_all

bindkey $ZSH_FZF_SELECT_FILE_BIND fzf_select_file
