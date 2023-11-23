# do nothing if fzf is not installed
(( ! $+commands[fzf] )) && return

# do nothing if bat is not installed
(( ! $+commands[bat] )) && return

(( ! ${+ZSH_FZF_SELECT_FILE_FZF_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_ARGS='--tac --header-first --header-lines=1 --ansi -1 --reverse +s -m -x -e --scheme=path'
(( ! ${+ZSH_FZF_SELECT_FILE_EZA_BINARY} )) && typeset -g ZSH_FZF_SELECT_FILE_EZA_BINARY="eza"
(( ! ${+ZSH_FZF_SELECT_FILE_EZA_COLORS} )) && typeset -g ZSH_FZF_SELECT_FILE_EZA_COLORS="da=00"
(( ! ${+ZSH_FZF_SELECT_FILE_EZA_ARGS} )) && typeset -g ZSH_FZF_SELECT_FILE_EZA_ARGS='--no-git -l --no-user --no-permissions --no-filesize --time-style=+%Y/%m/%d-%H:%M --icons=always --color=always'
(( ! ${+ZSH_FZF_SELECT_FILE_BIND} )) && typeset -g ZSH_FZF_SELECT_FILE_BIND='^x^f'
(( ! ${+ZSH_FZF_SELECT_ALL_FILES_BIND} )) && typeset -g ZSH_FZF_SELECT_FILE_BIND='^x^a'
(( ! ${+ZSH_FZF_SELECT_FILE_FZF_PREVIEW} )) && typeset -g ZSH_FZF_SELECT_FILE_FZF_PREVIEW="if [[ -d {-1} ]];then eza --level 2 --tree --color=always --group-directories-first {-1};elif [[ -f {-1} ]];then bat --color=always {-1};fi"

__fzf_select_file() {
    # get current word
    local exargs=("$@")
    local current=${LBUFFER##* }
    local currentq
    [[ -n $current ]] && currentq="-q${current}"
    local choices=(${(f)"$(env EZA_COLORS=${ZSH_FZF_SELECT_FILE_EZA_COLORS} ${ZSH_FZF_SELECT_FILE_EZA_BINARY} ${=ZSH_FZF_SELECT_FILE_EZA_ARGS} ${=exargs} .|fzf ${=currentq} --bind="ctrl-v:change-preview-window(hidden)" --preview="${ZSH_FZF_SELECT_FILE_FZF_PREVIEW}" ${=ZSH_FZF_SELECT_FILE_FZF_ARGS})"})
    local result="${space}${(@q)${choices[@]/(#m)*/${${${(As: :)MATCH}[3,-1]}%% ->*}}}"
    (( ${#result} == 0 )) && return 1
    # replace current word with result
    [[ -n ${current} ]] && LBUFFER="${LBUFFER% *} "
    LBUFFER="$LBUFFER$result"
    return $?
}

_fzf_select_file() {
    __fzf_select_file
    zle reset-prompt
}

_fzf_select_file_all() {
    __fzf_select_file -a
    zle reset-prompt
}

autoload -U _fzf_select_file _fzf_select_file_all __fzf_select_file
zle -N _fzf_select_file
zle -N _fzf_select_file_all

bindkey $ZSH_FZF_SELECT_FILE_BIND _fzf_select_file
bindkey $ZSH_FZF_SELECT_ALL_FILES_BIND _fzf_select_file_all
