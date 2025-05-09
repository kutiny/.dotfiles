#! /bin/bash

source $(dirname "$0")/tools/kit.sh

is_open=false
label="USD"
value="N/A"

fetch_data() {
    local url="https://www.bna.com.ar/Personas"
    local html_response=$(curl --silent $url)
    local buy_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/main/div/div/div[4]/div[1]/div/div/div[2]/table/tbody/tr[1]/td[2]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')
    local sell_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/main/div/div/div[4]/div[1]/div/div/div[2]/table/tbody/tr[1]/td[3]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')
    local is_open=$(curl --silent https://open.bymadata.com.ar/vanoms-be-core/rest/api/bymadata/free/market-open \
--header 'Cache-Control: no-cache,no-store,max-age=1,must-revaliidate' \
--header 'Expires: 1' \
--header 'Options: dashboard')

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
        value="\$$value"
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

        if [ $diff -gt 60 ]; then
            update
        fi
    else
        update
    fi

    if [[ "$value" != "N/A" ]]; then
        print_pill $label "$value" $is_open
    fi
}

market

