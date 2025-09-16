#! /usr/bin/env bash

source $(dirname "$0")/tools/kit.sh

init() {
    local state=
    local system="$(uname)"

    if [[ "$system" == "Darwin" ]]; then
        which kubectl &> /dev/null
        isKubeAvailable=$?
        which timeout &> /dev/null
        isTimeoutAvailable=$?

        if [[ $isKubeAvailable -eq 1 || $isTimeoutAvailable -eq 1 ]]; then
            return
        fi
    fi

    if [[ "$system" == "Linux" ]]; then
        type kubectl > /dev/null
        isKubeAvailable=$?
        type timeout > /dev/null
            isTimeoutAvailable=$?

        if [[ $isKubeAvailable -eq 1 || $isTimeoutAvailable -eq 1 ]]; then
            return
        fi
    fi

    timeout 2 kubectl version &> /dev/null

    local code=$?
    local is_error=$(timeout 2 kubectl version | grep 'error' | wc -l)

    if [[ "$code" == "143" || "$code" == "1" || "$code" == "124" || "$is_error" == "1" ]]; then
        # state=""
        return
    elif [[ "$code" == "0" ]]; then
        state=$(kubectl config current-context)
        echo $state | grep -E '([a-zA-Z0-9-]+:){5}[a-z]+\/[a-z-]+' &> /dev/null
        isk=$?
        if [[ "0" == "$isk" ]]; then
            o=$(echo $state | awk -F'/' '{print $2}')
            u=$(echo $state | awk -F':' '{print $5}')
            z=STG
            if [[ "${u:1:1}" == "0" ]]; then
                z=PRD
            fi
            state="${o} [${z}]"
        fi
    fi

    print_pill "" "$state" "true" "color110"
}

init
