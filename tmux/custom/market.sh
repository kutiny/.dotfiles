#! /bin/bash

source $(dirname "$0")/tools/kit.sh

show_market() {
    local html_response=$(curl --silent https://dolarhoy.com/)
    local buy_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div/div[1]/div/div[1]/div/div[1]/div[1]/div[2]/text()" - |\
        tail -1 | tr -d '$')
    local sell_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div/div[1]/div/div[1]/div/div[1]/div[2]/div[2]/text()" - |\
        tail -1 | tr -d '$')

    local is_open=$(curl --silent https://open.bymadata.com.ar/vanoms-be-core/rest/api/bymadata/free/market-open)
    local label="BYMA"
    local value=""

    if [ ! -z $buy_price ] && [ ! -z $sell_price ]; then
        value=$(( $buy_price + ($sell_price - $buy_price) / 2 ))
        print_pill $label $value $is_open
    fi
}

show_market
