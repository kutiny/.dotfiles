#! /bin/bash

source $(dirname "$0")/tools/kit.sh

init() {
    local state=
    local system="$(uname)"

    if [[ "$system" == "Darwin" ]]; then
        which aws &> /dev/null
        isAwsAvailable=$?
        which timeout &> /dev/null
        isTimeoutAvailable=$?

        if [[ $isAwsAvailable -eq 1 || $isTimeoutAvailable -eq 1 ]]; then
            return
        fi
    fi

    if [[ "$system" == "Linux" ]]; then
        type aws > /dev/null
        isAwsAvailable=$?
        type timeout > /dev/null
            isTimeoutAvailable=$?

        if [[ $isAwsAvailable -eq 1 || $isTimeoutAvailable -eq 1 ]]; then
            return
        fi
    fi

    timeout 2 aws --version &> /dev/null

    local code=$?

    if [[ "$code" == "143" || "$code" == "1" || "$code" == "124" ]]; then
        state=""
    elif [[ "$code" == "0" ]]; then
        arn=$(aws sts get-caller-identity | jq -r '.Arn')
        if [[ "$arn" == "" ]]; then
            state=""
        else
            state=$(echo $arn | awk -F'/' '{ print $2 }' | awk -F'-' '{ print toupper($2"-"$3) }')
            echo $state | grep -E '([a-zA-Z0-9-]+:){5}[a-z]+\/[a-z-]+' &> /dev/null
            isk=$(echo $arn | awk -F':' '{ print $5 }')
            z=STG
            if [[ "0" == "${isk:1:1}" ]]; then
                z=PRD
            fi
            state="${state} [${z}]"
        fi
    fi

    print_pill " " "$state" "true" "color208"
}

init
