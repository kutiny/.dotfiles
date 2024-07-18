#!/bin/bash

function select_git_ssh() {
	echo -e "SSH Key set to \e[32m~/.ssh/$1";
	export GIT_SSH_COMMAND="ssh -i ~/.ssh/$1"
}

alias sgs=select_git_ssh
function update_branch() {
  cbranch=$(git branch --show-current)
  nbranch=$1
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
alias g=git
alias gb="git branch"
alias gch="git checkout"
alias gcb="git checkout -b"
alias cdw="cd /c/workspace/"
alias gbd="git branch -d"

