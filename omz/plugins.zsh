PLUGINS_DIR=${HOME}/.local/omz/plugins/

if [[ ! -d ${PLUGINS_DIR} ]]; then
    mkdir -p $PLUGINS_DIR
fi

COLOR_YELLOW="\033[1;33m"
COLOR_RESET="\033[0m"

function clone_or_update_plugin {
    plugin_url=$1
    plugin_name=$2
    dir="${PLUGINS_DIR}/${plugin_name}"

    if [[ ! -d ${dir} ]]; then
        echo -e "Cloning ${plugin_name}..."
        git clone ${plugin_url} ${dir} > /dev/null 2>&1
    elif [[ $UPDATE_OMZ_PLUGINS -eq 1 ]]; then
        echo -e "Updating ${plugin_name}..."
        cd $dir
        git pull
    fi

    source ${dir}/${plugin_name}.zsh
}

clone_or_update_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
clone_or_update_plugin https://github.com/zsh-users/zsh-autosuggestions.git zsh-autosuggestions

autoload -U compinit; compinit
clone_or_update_plugin https://github.com/Aloxaf/fzf-tab.git fzf-tab

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls --color=always \${realpath}"

# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
