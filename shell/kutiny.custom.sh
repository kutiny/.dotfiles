#! /bin/zsh

# TODO: Ver si lo puedo migrar a un plugin o similar, subido en git o algo
alias note="~/workspace/notetaking/note.js"

# function cd() {
#     builtin cd "$@"

#     if [[ "$(which nvm)" == "nvm not found" ]]; then
#         return
#     fi

#     current=$(node -v)

#     if [[ -f "package.json" ]]; then
#         echo "Using node \e[33m${current}\e[0m"
#     fi

#     if [[ "$(which awk)" == "awk not found" ]]; then
#         echo "\e[033awk not installed. Skipping check.\e[0m"
#     fi

#     nv=0
#     if [[ -f ".nvmrc" ]]; then
#         nv=$(cat .nvmrc)
#     fi
#     if [[ -f ".node_version" ]]; then
#         nv=$(cat .node_version)
#     fi

#     v=$(echo $nv | tr -d 'v')

#     target_major=$(echo $v | awk -F'.' '{ print $1 }')
#     target_minor=$(echo $v | awk -F'.' '{ print $2 }')
#     target_patch=$(echo $v | awk -F'.' '{ print $3 }')

#     c=$(echo $current | tr -d 'v')

#     current_major=$(echo $c | awk -F'.' '{ print $1 }')
#     current_minor=$(echo $c | awk -F'.' '{ print $2 }')
#     current_patch=$(echo $c | awk -F'.' '{ print $3 }')

#     function offer_install {
#         read "r?Would you like to install ${nv}? (y/N): "

#         if [[ "$r" == "y" || "$r" == "Y" ]]; then
#             echo "\e[33mWill install node ${nv}"
#             nvm install ${nv}
#             nvm use ${nv}
#         fi
#     }

#     if [[ "$nv" != "0" ]]; then
#         echo "Current project requires \e[33m${nv}\e[0m"

#         if [[ "${current_major}" != "${target_major}" ]]; then
#             echo "\e[31mCurrent version do not satisfy project's version\e[0m"
#             is_compat=$(nvm ls --no-colors "${nv}" | tail -1 | tr -d ' ')

#             if [[ "${is_compat}" == "N/A" ]]; then
#                 echo "There's no already installed compatible version with ${nv}"
#                 offer_install
#             else
#                 nvm use v${target_major}
#             fi
#         fi
#     fi

# }
