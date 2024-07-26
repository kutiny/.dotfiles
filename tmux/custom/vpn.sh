#! /bin/bash

source $(dirname "$0")/tools/kit.sh

showVpnStatus() {
    local vpnExecutable=~/.dotfiles/pub/scripts/vpnconnect.sh
    local tag="VPN"
    local value="󰶼"
    local on="true"
    local status=$($vpnExecutable -s | grep -E 'state|Status' | tail -n 1 | awk -F': ' '{ print $3 }')

    if [[ $status ~= "No such" ]]; then
        return
    fi

    if [[ "$status" == "Disconnected" ]]; then
        on="false"
        value="󰶹"
    fi

    print_pill $tag $value $on
}

showVpnStatus
