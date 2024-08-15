#! /bin/bash

source $(dirname "$0")/tools/kit.sh

init() {
    local fg="colour7"
    local state=
    local icon="󱃾"
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
        state=""
    elif [[ "$code" == "0" ]]; then
        fg=white
        state=$(kubectl config current-context)
    fi

    print_pill "K8S" $state "true" "#7895B2"
}

init
