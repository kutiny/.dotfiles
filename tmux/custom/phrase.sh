#! /bin/bash
STATE_FILE="$HOME/.phrase.state"
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"
curr=$(cat "$STATE_FILE")
curr=$((curr + 1))

phrase=""
size=${#phrase}

if [[ $curr -gt $size ]]; then
    curr=0
fi

echo "$curr" > $STATE_FILE

printf "${phrase:0:$curr}"

