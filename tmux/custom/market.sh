#! /bin/bash

source $(dirname "$0")/tools/kit.sh

show_market() {
    local html_response=$(curl --silent https://dolarhoy.com/)
    local buy_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div[2]/div[1]/div/div[2]/div[3]/div/div[1]/div[2]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')
    local sell_price=$(echo $html_response | \
        xmllint --nowarning --html --xpath \
        "/html/body/div[3]/div[2]/div[1]/div[1]/div[2]/section/div/div/div[2]/div[1]/div/div[2]/div[3]/div/div[3]/div[1]/div[2]/text()" - |\
        tail -1 | tr -d '$' | sed 's/\..*//g')

    local is_open=$(curl --silent https://open.bymadata.com.ar/vanoms-be-core/rest/api/bymadata/free/market-open)
    local label="BYMA"
    local value=""

    if [ ! -z $buy_price ] && [ ! -z $sell_price ]; then
        bp="parseFloat('$buy_price'.replace('.', '.'))"
        sp="parseFloat('$sell_price'.replace('.', '.'))"
        node_cmd="process.stdout.write((($bp + ($sp- $bp) / 2).toFixed(2)))"
        value=$(node -e "$node_cmd")
        print_pill $label $value $is_open
    fi
}

show_market
