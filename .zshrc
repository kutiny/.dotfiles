# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"
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

source ~/.dotfiles/pub/omz/plugins.zsh

# opencode
export PATH=/Users/alex/.opencode/bin:$PATH

# GPG
export GPG_TTY=$(tty)

gpgconf --launch gpg-agent >/dev/null 2>&1

# fnm
if [[ "$(uname)" == "Darwin" ]] && [[ "$(type -a brew)" != "brew not found" ]]; then
    FNM_PATH="/opt/homebrew/opt/fnm/bin"
fi

if [[ ! -z $FNM_PATH ]] && [[ -d "$FNM_PATH" ]]; then
  eval "$(fnm env --shell zsh)"
fi
