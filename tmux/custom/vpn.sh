#! /usr/bin/env bash

source $(dirname "$0")/tools/kit.sh

showVpnStatus() {
    local nocolor="$1"
    local vpnExecutable=~/.dotfiles/pub/scripts/vpnconnect.sh
    local tag="VPN"
    local value="󰶼"
    local on="true"
    local status=$($vpnExecutable -s | grep -E 'state|Status' | tail -n 1 | awk -F': ' '{ print $3 }')

    if [[ $status == "" ]]; then
        if [[ "$nocolor" == "NOCOLOR" ]]; then
            on="false"
        value="󰶹"
        else
            return
        fi
    fi

    if [[ "$status" == "Disconnected" ]]; then
        if [[ "$nocolor" == "NOCOLOR" ]]; then
            on="false"
        value="󰶹"
        else
            return
        fi
    fi

    if [[ "$nocolor" == "NOCOLOR" ]]; then
        if [[ "$on" == "true" ]]; then
            printf "Online"
        else
            printf "Offline"
        fi
    else
        print_pill $tag $value $on
    fi
}

showVpnStatus $1
