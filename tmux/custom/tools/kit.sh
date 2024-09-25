#! /bin/bash

function print_pill {
    tag=$1
    value=$2
    on=$3
    bg_color=$4
    fg_color=$5

    local red_bg="#C5705D"
    local green_bg="#BACD92"
    local white_fg="#FAFAFA"
    local dark_fg="#2D2D2D"

    local tag_bg=$red_bg
    local tag_fg=$white_fg

    local value_bg="#D3D3C3"
    local value_fg=$dark_fg

    if [[ "$on" == "true" ]]; then
        tag_bg=$green_bg
        tag_fg=$dark_fg
    fi

    if [[ "$bg_color" != "" ]]; then
        tag_bg=$bg_color
    fi

    if [[ "$fg_color" != "" ]]; then
        tag_fg=$fg_color
    fi

    local prefix="#[fg=$tag_bg]#[bg=${tag_bg},fg=${tag_fg}]$tag #[bg=${value_bg},fg=${value_fg}]"
    local suffix="#[bg=default,fg=${value_bg}]#[bg=default,fg=white]"
    printf "${prefix} ${value}${suffix} "
}
