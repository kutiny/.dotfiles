#! /bin/bash

function print_pill {
    tag=$1
    value=$2
    on=$3

    local tag_bg="#FF8787"
    local tag_fg="#000000"
    local value_bg="#DADADA"
    local value_fg="#000000"

    if [[ "$on" == "true" ]]; then
        tag_bg="#BACD92"
    fi

    local prefix="#[fg=$tag_bg]#[bg=${tag_bg},fg=${tag_fg}]$tag #[bg=${value_bg},fg=${value_fg}]"
    local suffix="#[bg=default,fg=${value_bg}]#[bg=default,fg=white]"
    printf "${prefix} ${value}${suffix} "
}
