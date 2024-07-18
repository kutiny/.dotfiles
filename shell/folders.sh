#! /bin/bash
function h {
    folders_file=~/.ffolders_file

    if [[ ! -z $FFOLDERS_FILE ]]; then
        folders_file=$FFOLDERS_FILE
    fi

    if [[ ! -f $folders_file ]]; then
        touch $folders_file
    fi

    if [[ ! -z $1 ]]; then
        case $1 in
            add)
                echo -e "Adding \x1b[32m$(pwd)\x1b[0m to folders"
                echo $(pwd) >> $folders_file
                ;;
            reset)
                echo -e "\x1b[33mClearing directory list..\x1b[0m"
                echo "" > $folders_file
                ;;
            *)
                echo -e "\x1b[31mUnknown command $1\x1b[0m"
                ;;
        esac

    else
        folders=()

        while read folder; do
            if [[ -z $folder || "${folder:0:1}" == "#" ]]; then
                continue
            fi

            if [[ "${folder:0:1}" == "~" ]]; then
                folder="$HOME$(echo $folder | tr -d '~')"
            fi

            # TODO: Add ignore list?
            folders+=$(find $folder -mindepth 1 -maxdepth 1 -type d ! -name .git ! -name node_modules)
        done < $folders_file

        if [[ "" == ${folders[*]} ]]; then
            echo -e '\x1b[31mThere are no folders in the list.\n\x1b[0mIf you want to add current directory folders you can run \x1b[33m`h add`\x1b[0m command.'
        else

            homedir=$(echo "$HOME" | sed 's/\//\\\//g')

            dest=$(echo ${folders[*]} \
                | tr ' ' '\n' \
                | sort | uniq \
                | sed "s/${homedir}/\~/g"\
                | fzf)
            if [[ ! -z $dest ]]; then
                if [[ "${dest:0:1}" == "~" ]]; then
                    dest="$HOME$(echo $dest | tr -d '~')"
                fi
                cd $dest
            fi
        fi

    fi
}

