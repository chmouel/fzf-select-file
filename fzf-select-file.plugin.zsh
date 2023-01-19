# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

# do nothing if exa is not installed
(( ! $+commands[exa] )) && return

# do nothing if bat is not installed
(( ! $+commands[bat] )) && return

(( ! ${+ZSH_FZF_SELECT_FILE_FZF_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_ARGS='--tac --header-first --height=10 --header-lines=1 --ansi -1 --reverse +s -m -x -e'
(( ! ${+ZSH_FZF_SELECT_FILE_EXA_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_EXA_ARGS='--header --long --color=always --sort=newest --icons --color-scale --no-permissions --no-filesize --no-user'
(( ! ${+ZSH_FZF_SELECT_FILE_BIND} )) && typeset -g ZSH_FZF_SELECT_FILE_BIND='^x^f'
(( ! ${+ZSH_FZF_SELECT_FILE_FZF_PREVIEW} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_PREVIEW='if [[ -d {-1} ]];then exa --level 2 --tree --color=always --group-directories-first {-1};elif [[ -f {-1} ]];then bat --color=always {-1};fi'

__fzf_select_file() {
    local exa_extras=$@
    local choices=(${(f)"$(exa ${=exa_extras} ${=ZSH_FZF_SELECT_FILE_EXA_ARGS} .|fzf --bind="ctrl-v:change-preview-window(nohidden)" --preview-window=hidden --preview="${ZSH_FZF_SELECT_FILE_FZF_PREVIEW}" ${=ZSH_FZF_SELECT_FILE_FZF_ARGS})"})
    local space=""
    local goend=0
    (( ${#choices} )) || return 1
    if [[ -n ${BUFFER} ]];then
        [[ "$BUFFER" != *" " ]] && space=" "
        goend=1
    else
        space=" "
    fi
    BUFFER+="${space}${(@q)${choices[@]/(#m)*/${${${(As: :)MATCH}[5,-1]}%% ->*}}}"
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
