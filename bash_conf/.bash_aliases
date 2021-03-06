#!/bin/bash

alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'
alias fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias fpm.restart='php-fpm.stop && php-fpm.start'
alias mysql.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias mysql.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
alias mysql.restart='mysql.stop && mysql.start'
alias nginx.logs.error='tail -250f /usr/local/etc/nginx/logs/error.log'
alias nginx.logs.access='tail -250f /usr/local/etc/nginx/logs/access.log'
alias nginx.logs.default.access='tail -250f /usr/local/etc/nginx/logs/default.access.log'
alias nginx.logs.default-ssl.access='tail -250f /usr/local/etc/nginx/logs/default-ssl.access.log'
alias nginx.logs.phpmyadmin.error='tail -250f /usr/local/etc/nginx/logs/phpmyadmin.error.log'
alias nginx.logs.phpmyadmin.access='tail -250f /usr/local/etc/nginx/logs/phpmyadmin.access.log'

alias find.port.occupant='find_port_occupant'
alias kill.port.occupant='kill_port_occupant'
alias msql='mysql -u root -p'

alias git.st='git status'
alias git.fixup='git commit --fixup'
alias git.graph="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(70,trunc)%s%Cgreen%aI' --graph"
alias git.review="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(68,trunc)%s%Cgreen%aI' --reverse -p"
alias git.wip="git add . ; git commit -a -m WIP"
alias git.lg="git log --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(20)%cn%Cred%<(70,trunc)%s%Cgreen%aI'"
alias git.lgn="git log -n 10 --pretty='%C(auto)%<(40,trunc)%d%C(green)%h %Cblue%<(10,trunc)%cn%Cred%<(70,trunc)%s'"
alias git.append="git commit --amend --no-edit"
alias git.sync="git fetch -p && git rebase origin/master"
alias git.down="git_down"
alias git.up="git_up"
alias psql.crash="psql crash crash -p 5442 -h localhost"
alias psql.crash_test="psql crash_test crash -p 5442 -h localhost"
alias pgcli.crash='pgcli -p 5442 -h localhost crash postgres'
alias pgcli.crash_test='pgcli -p 5442 -h localhost crash_test postgres'
alias qaupdate="git pull && git submodule update --init && twig feature qainit update"
alias qainit='twig feature qainit '
alias qashutdown='twig feature qainit shutdown'
alias emacs="emacs -fs -nw"
alias soapui="/home/blacksheep/soapui/bin/SoapUI-5.6.0"
alias reset.audio="pulseaudio -k && sudo alsa force-reload"
alias notepad="cd Dropbox/appunti && vim -c \":NERDTree\" && cd"
alias ssh="kitty +kitten ssh"
alias biscuit-decrypt='aws-vault exec secrets -- biscuit get -f '
alias biscuit-list='aws-vault exec secrets -- biscuit list -f '
#alias cat='bat'
