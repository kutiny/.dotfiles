#! /usr/bin/env bash

function select_git_ssh() {
    param=$1
    echo $param
    if [[ -z $param ]]; then
        if [[ -d ~/.ssh ]]; then
            echo ".ssh exists"
            param=$(ls ~/.ssh/ | grep -v -E 'known_hosts|authorized_keys|.*\.key$|.*\.pub' | fzf --prompt="Select SSH Key: ")
        else
            echo "Couldn't read ~/.ssh directory. Please enter key manually: "
            read param
        fi
    fi

    export GIT_SSH_COMMAND="ssh -i ~/.ssh/${param}"
	echo -e "SSH Key set to \e[32m~/.ssh/${param}"
}

alias sgs=select_git_ssh

function update_branch() {
  cbranch=$(git branch --show-current)
  nbranch=$1
  if [[ -z $nbranch ]]; then
      echo -e "\x1b[33mUsage: update_branch [branch to update]\x1b[0m"
      return
  fi
  git checkout $nbranch
  git pull
  git checkout $cbranch
}

function post_merge() {
    target_branch=$1
    merged_branch=$(git branch --show-current)
    usage="\e[33mUsage:\e[0m post_merge [checkout_branch]"

    if [ -z $target_branch ]; then
        echo -e "$usage"
        return
    fi

    echo -e "\e[33mCheckout to $target_branch\e[0m"
    git checkout $target_branch
    git pull
    git branch -d $merged_branch
    echo -e "\e[33mDone!"
}

alias ub=update_branch

if [[ $(uname) == "Darwin" ]] && [[ -d ~/workspace ]]; then
    alias cdw="cd ~/workspace"
elif [[ -d /c/workspace ]]; then
    alias cdw="cd /c/workspace/"
fi

