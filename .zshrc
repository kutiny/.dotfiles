# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"
CASE_SENSITIVE="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions aws kubectl)
source $ZSH/oh-my-zsh.sh

# Disable analytics for homebrew
export HOMEBREW_NO_ANALYTICS=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.dotfiles/pub/shell/.loaderrc
source ~/.dotfiles/pub/zsh/custom

export TERM=xterm-256color

function prompt_node_version() {
    if [ -f package.json ]; then
        if command -v node > /dev/null 2>&1; then
            echo "  $(node -v) "
        fi
    fi
}

# pnpm
if [[ -d ${HOME}/.pnpm ]]; then
    export PNPM_HOME="${HOME}/.pnpm"
elif [[ -d ${HOME}/Library/.pnpm ]]; then
    export PNPM_HOME="${HOME}/Library/.pnpm"
fi

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$HOME/.local/bin:$PATH"

# fnm
export PATH="/Users/alex/.local/state/fnm_multishells/3998_1779562374736/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/alex/.local/state/fnm_multishells/3998_1779562374736"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/alex/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"

source ~/.dotfiles/pub/omz/plugins.zsh

# opencode
export PATH=/Users/alex/.opencode/bin:$PATH

# GPG
export GPG_TTY=$(tty)

gpgconf --launch gpg-agent >/dev/null 2>&1
