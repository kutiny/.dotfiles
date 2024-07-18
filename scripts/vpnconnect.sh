#!/bin/bash

# Required environment variables
# VPN_USERNAME=""
# VPN_HOST_NAME=""
# VPN_GROUP=""

PASS_FILE_PATH=~/.enc_pass
TOTP_FILE_PATH=~/.enc_totp
ANYCONNECT_PATH=/opt/cisco/anyconnect/bin/vpn

# COMMAND_NAME="<path-to-script>/$(awk -F "/" '{print $(NF)}' <(echo "$0"))"

HELP_MESSAGE="\n\
Usage:\n\
	Update password:\n\
          vpnconnect <--update-pass | -u> \n\
	Update TOTP secret:\n\
	  vpnconnect <--update-totp | -t> \n\
	Connect to VPN:\n\
	  vpnconnect <--vpn-connect | -c> <otp> \n\
	Disconnect from VPN:\n\
	  vpnconnect <--vpn-disconnect | -d> \n\
	Show VPN status:\n\
	  vpnconnect <--vpn-status | -s> \n\
        Show this message:\n\
	  vpnconnect <--help | -h> \n\
"

YELLOW='\x1b[33m'
GREEN='\x1b[32m'
RED='\x1b[31m'
NC='\x1b[0m'

PROMPT_PREFIX="${GREEN}[vpnconnect]: ${NC}"

verbose=0

function activate_colors() {
	COLOR=$1
	echo -ne "${COLOR}"
}

function print_error() {
	echo -ne "$PROMPT_PREFIX"
	activate_colors "${RED}"
	echo -e "$1"
	activate_colors "${NC}"
}

function update_password() {
	echo -ne "$PROMPT_PREFIX "
	echo -n "Enter new password: "
	read -r -s new_password
	echo
	echo -ne "$PROMPT_PREFIX "
	echo -n "Enter password encription key: "
	read -r -s password_key
	echo

	encrypted_password=$(echo "$new_password" | openssl enc -base64 -e -aes-256-cbc -salt -pass "pass:$password_key" -pbkdf2)
	echo "$encrypted_password" >"$PASS_FILE_PATH"
}

function update_totp() {
	echo -ne "$PROMPT_PREFIX "
	echo -n "Enter new TOTP secret: "
	read -r -s new_totp
	echo
	echo -ne "$PROMPT_PREFIX "
	echo -ne "Enter TOTP secret encription key: "
	read -r -s totp_key
	echo

	encrypted_totp_secret=$(echo "$new_totp" | openssl enc -base64 -e -aes-256-cbc -salt -pass "pass:$totp_key" -pbkdf2)
	echo "$encrypted_totp_secret" >"$TOTP_FILE_PATH"
}

function vpn_connect() {
	OTP=$1
	is_connected=$("$ANYCONNECT_PATH" status | grep --count 'state: Connected')
	if [[ $is_connected -ne 0 ]]; then
		echo -ne "$PROMPT_PREFIX"
		activate_colors "${YELLOW}"
		echo "VPN already connected"
		activate_colors "${NC}"
		exit 0
	fi

	if [[ $OTP == "" ]] && [[ ! -f $TOTP_FILE_PATH ]]; then
		print_error "Error, TOTP secret key not found"
		exit 1
	fi

	if [[ $VPN_USERNAME == "" ]]; then
		print_error "Error: Username not found, set the corresponding script variable"
		exit 1
	fi

	encrypted_password=$(cat "$PASS_FILE_PATH")
	echo -ne "$PROMPT_PREFIX"
	echo -n "Enter password key: "
	read -r -s password_key
	echo
	decrypted_password=$(echo "$encrypted_password" | openssl enc -base64 -d -aes-256-cbc -salt -pass "pass:$password_key" -pbkdf2)
	if [[ $? -ne 0 ]]; then
		print_error "Error: Invalid password key"
		exit 1
	fi

	if [[ $OTP == "" ]]; then
		encrypted_totp_secret=$(cat "$TOTP_FILE_PATH")
		echo -ne "$PROMPT_PREFIX"
		echo -n "Enter TOTP secret key: "
		read -r -s totp_key
		echo
		decrypted_totp_secret=$(echo "$encrypted_totp_secret" | openssl enc -base64 -d -aes-256-cbc -salt -pass "pass:$totp_key" -pbkdf2)
		OTP=$(oathtool --totp -b "$decrypted_totp_secret")

		if [[ $? -ne 0 ]]; then
			print_error "Error: TOTP key"
			exit 1
		fi
	fi

    if [[ "$verbose" == "1" ]]; then
        printf "%s\n%s\n%s\n%s\n" "$VPN_GROUP" "$VPN_USERNAME" "$decrypted_password" "$OTP" | $ANYCONNECT_PATH -s connect "$VPN_HOST_NAME"
    else
        printf "%s\n%s\n%s\n%s\n" "$VPN_GROUP" "$VPN_USERNAME" "$decrypted_password" "$OTP" | $ANYCONNECT_PATH -s connect "$VPN_HOST_NAME" | grep 'state' | awk -F ': ' 'END { print "Status:", $2 }'
    fi
}

function vpn_disconnect() {
    if [[ "$verbose" == "1" ]]; then
        $ANYCONNECT_PATH disconnect
    else
        $ANYCONNECT_PATH disconnect | grep 'state' | awk -F ': ' 'END { print "Status:", $2 }'
    fi
}

function vpn_status() {
    echo -ne $PROMPT_PREFIX
    if [[ "$verbose" == "1" ]]; then
        $ANYCONNECT_PATH status
    else
        $ANYCONNECT_PATH status | grep 'state' | awk -F ': ' 'NR==1{ print "Status:", $2 }'
    fi
}

echo -ne "$PROMPT_PREFIX"
echo -e "VPN Connect"
echo -ne "$PROMPT_PREFIX"
echo -e "Version 1.0.0"

if [[ ! -f "$ANYCONNECT_PATH" ]]; then
    activate_colors "${RED}"
    echo -ne "ANYCONNECT_PATH directs nowhere."
    activate_colors "${NC}"
fi

if [ $# -ne 0 ]; then
	while [ $# -gt 0 ]; do
        no=0
        for param in "$@"; do
            no=$((no+1))
            if [[ "$param" == "-v" || "$param" == "--verbose" ]]; then
                echo -e "${PROMPT_PREFIX}Enabling verbose mode"
                verbose=1
                set -- "${@:1:no-1}" "${@:no+1}"
            fi
        done

		case $1 in
			--update-totp | -t)
				update_totp
				shift
				exit 0
				;;
			--update-pass | -u)
				update_password
				shift
				exit 0
				;;
			--vpn-connect | -c)
                shift
				vpn_connect "$@"
				exit 0
				;;
			--vpn-disconnect | -d)
				vpn_disconnect
				exit 0
				;;
			--vpn-status | -s)
                shift
				vpn_status "$@"
				exit 0
				;;
			--help | -h)
				echo -e "$HELP_MESSAGE"
				shift
				;;
            --verbose | -v)
                ;;
			*)
				print_error "Error: Invalid argument $1"
				echo -e "$HELP_MESSAGE"
				exit 1
				;;
		esac
	done
fi

