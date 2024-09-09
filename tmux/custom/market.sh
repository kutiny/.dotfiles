#! /bin/bash

source $(dirname "$0")/tools/kit.sh

show_market() {
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

    local is_open=$(curl --silent https://open.bymadata.com.ar/vanoms-be-core/rest/api/bymadata/free/market-open)
    local label="BYMA"
    local value=""

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
            change_icon="#[fg=#FF8787]#[fg=#000000]"
        else
            change_icon="#[fg=#BACD92]#[fg=#000000]"
        fi

        print_pill $label "$change_icon $value" $is_open
    fi
}

show_market
