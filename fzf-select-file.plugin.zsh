# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

# do nothing if bat is not installed
(( ! $+commands[bat] )) && return

(( ! ${+ZSH_FZF_SELECT_FILE_FZF_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_ARGS='--tac --header-first --header-lines=1 --ansi -1 --reverse +s -m -x -e'
(( ! ${+ZSH_FZF_SELECT_FILE_EZA_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_EZA_ARGS='--long --header -a --color=always --sort=newest --color-scale --no-permissions --no-user'
(( ! ${+ZSH_FZF_SELECT_FILE_BIND} )) && typeset -g ZSH_FZF_SELECT_FILE_BIND='^x^f'
(( ! ${+ZSH_FZF_SELECT_FILE_FZF_PREVIEW} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_PREVIEW="if [[ -d {-1} ]];then eza --level 2 --tree --color=always --group-directories-first {-1};elif [[ -f {-1} ]];then bat --color=always {-1};fi"

_fzf_select_file() {
    local choices=(${(f)"$(eza ${=ZSH_FZF_SELECT_FILE_EZA_ARGS} .|fzf --bind="ctrl-v:change-preview-window(hidden)" --preview="${ZSH_FZF_SELECT_FILE_FZF_PREVIEW}" ${=ZSH_FZF_SELECT_FILE_FZF_ARGS})"})
    local result="${space}${(@q)${choices[@]/(#m)*/${${${(As: :)MATCH}[5,-1]}%% ->*}}}"
    (( ${#result} == 0 )) && return 1
    LBUFFER="$LBUFFER$result"
    return $?
}

autoload -U _fzf_select_file; zle -N _fzf_select_file
bindkey $ZSH_FZF_SELECT_FILE_BIND _fzf_select_file
