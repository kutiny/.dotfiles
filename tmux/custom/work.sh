#! /bin/bash

source $(dirname "$0")/tools/kit.sh

function work {
    # Bash: get true if current time is between 9am and 6pm and day is not saturday or sunday
    is_worktime=$(date +"%H" | awk '{print ($1 >= 9 && $1 < 18)}')
    is_weekend=$(date +"%u" | awk '{print ($1 >= 6)}')
    tag="Free"
    is_active=true

    if [[ $is_worktime && !$is_weekend ]]; then
        is_active=false
        tag="Working"
    fi

    # get remaining time until 18:00hs in human format and in shell code (macos)
    rem_time=$(date -j -f "%H:%M:%S" "$(date +"%T")" "18:00:00" +%S)

    # Get the current date and time in seconds since epoch
    current_time=$(date +%s)

    # Get today's date with 18:00 time in seconds since epoch
    target_time=$(date -j -f "%Y-%m-%d %H:%M:%S" "$(date +'%Y-%m-%d') 18:00:00" +%s)

    # Calculate the remaining seconds
    remaining_seconds=$((target_time - current_time))

    # Convert remaining seconds to hours, minutes, and seconds
    hours=$((remaining_seconds / 3600))
    minutes=$(((remaining_seconds % 3600) / 60))

    # Add leading zeros to hours, minutes and seconds
    hours=$(printf "%02d" $hours)
    minutes=$(printf "%02d" $minutes)

    print_pill $tag "$hours:$minutes" $is_active
}

work
