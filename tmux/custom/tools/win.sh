#! /bin/sh

# declare -A window_emojis
# emoji_window_emojis[1]="󰬺"
# emoji_window_emojis[2]="󰬻"
# emoji_window_emojis[3]="󰬼"
# emoji_window_emojis[4]="󰬽"
# emoji_window_emojis[5]="󰬾"
# emoji_window_emojis[6]="󰬿"
# emoji_window_emojis[7]="󰭀"
# emoji_window_emojis[8]="󰭁"
# emoji_window_emojis[9]="󰭂"
# emoji_window_emojis[10]="󰿩"
#
win_index=$1
win_len=$(tmux list-windows -F '#{window_index}' | wc -l | tr -d ' ')

# echo " ${emoji_window_emojis[$win_index]:-}${emoji_window_emojis[$win_len]:-}"
echo " ${win_index:-}/${win_len:-}"

