#!/bin/bash

alias git.st="git status"
alias git.fixup="git commit --fixup"
alias git.graph="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(70,trunc)%s%Cgreen%aI' --graph"
alias git.review="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(68,trunc)%s%Cgreen%aI' --reverse -p"
alias git.wip="git add . ; git commit -a -m WIP"
alias git.lg="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(70,trunc)%s%Cgreen%aI'"
alias git.lgn="git log -n 10 --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(10,trunc)%cn%Cred%<(70,trunc)%s'"
alias git.append="git commit --amend --no-edit"
alias git.sync="git fetch -p && git rebase origin/master"
alias git.down="git_down"
alias git.up="git_up"
alias git.last="last_revision"
alias git.auto.fixup="auto_fixup"
alias git.names="git show --oneline --name-only"
alias git.squash="git rebase -i --autosquash"

alias vim="nvim"
alias notepad="cd ~/Documents/appunti && vim -c \":NERDTree\" && cd"

alias find.port.occupant="find_port_occupant"
alias kill.port.occupant="kill_port_occupant"
alias ll="ls -lha --color"
alias rebar="rebar3"
alias ringo="AWS_PROFILE=secrets ringo"

alias docker.run="docker_run"
alias docker.down="docker-compose down"

alias ku='kubectl'
alias vimp='vim `ls *.vp |sort -g`'
alias hx='helix'
alias em='emacs --no-window-system'
     
if [ -f ~/.bash_local_aliases ]; then
    . ~/.bash_local_aliases
fi

