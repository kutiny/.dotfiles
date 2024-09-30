#! /bin/bash

source $(dirname "$0")/tools/kit.sh

is_open=false
label="ByMA"
value=""

fetch_data() {
    local html_response=$(curl --silent https://dolarhoy.com/)
    local buy_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div[2]/div[1]/div/div[2]/div[4]/div/div[1]/div[2]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')
    local sell_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div[2]/div[1]/div/div[2]/div[4]/div/div[3]/div[1]/div[2]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')
    local change=$(echo $html_response |\
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div[2]/div[1]/div/div[2]/div[4]/div/div[3]/div[2]/div/text()" - |\
        tail -1)
    is_open=$(curl --silent https://open.bymadata.com.ar/vanoms-be-core/rest/api/bymadata/free/market-open)


    if [ ! -z $buy_price ] && [ ! -z $sell_price ]; then
        value="$buy_price $sell_price"

        if [[ "$buy_price" =~ ^[0-9]*,[0-9]* ]]; then
            buy_price=$(echo $buy_price | tr -d ',')
        else
            buy_price=$((buy_price * 100))
        fi

        if [[ "$sell_price" =~ ^[0-9]*,[0-9]* ]]; then
            sell_price=$(echo $sell_price | tr -d ',')
        else
            sell_price=$((sell_price * 100))
        fi

        value=$(( (buy_price + sell_price) / 2 ))
        value="$(( value / 100 )).${value: -2}"

        if [[ "$change" =~ ^-.*$ ]]; then
            change_icon=""
        else
            change_icon=""
        fi

        value="$change_icon $value"
    fi
}

function market {
    now=$(date +%s)
    diff=0
    last_update=-1

    function update {
        now=$(date +%s)
        fetch_data
        echo "$now" > ~/.tmp_time
        echo "$is_open" >> ~/.tmp_time
        echo "$value" >> ~/.tmp_time
    }

    if [ -f ~/.tmp_time ]; then
        last_update_data=$(cat ~/.tmp_time)
        last_update=$(echo "$last_update_data" | sed -n 1p)
        is_open=$(echo "$last_update_data" | sed -n 2p)
        value=$(echo "$last_update_data" | sed -n 3p)
        last_update=$(date -j -f "%s" "$last_update" +%s)
        diff=$((now - last_update))

        if [ $diff -gt 30 ]; then
            update
        fi
    else
        update
    fi

    print_pill $label "$value" $is_open
}

market

