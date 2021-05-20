#!/bin/bash

export ELSP="$HOME/.elsp-1.11.2-otp-23"
PATH="${PATH}:/usr/local/bin"

if [ -f ~/.bashlib ]; then
    . ~/.bashlib
fi

if [ -f ~/.bash_docker ]; then
    . ~/.bash_docker
fi

if [ -f ~/.transfer.sh ]; then
  . $HOME/.transfer.sh
fi

if [ -f $HOME/.cargo/env  ]; then
  . $HOME/.cargo/env
fi

if [ -d $HOME/.asdf ]; then
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
fi

if [ -f $HOME/.bash_prompt  ]; then
  . $HOME/.bash_prompt
fi

if [ -f $HOME/.bash_py  ]; then
  . $HOME/.bash_py
fi

if [ -f $HOME/.bash_twig  ]; then
  . $HOME/.bash_twig
fi

if [ -d /home/linuxbrew ]; then
  export PATH="${PATH}:/home/linuxbrew/.linuxbrew/bin"
fi

export EDITOR="vim"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="${PATH}:~/elm-language-server;~/.els"
export PATH="${PATH}:/home/blacksheep/.asdf/installs/golang/1.16rc1/go/bin"
export PATH="${PATH}:/home/blacksheep/.local/share/bin"
export PATH="${PATH}:/snap/bin"
export PATH="${PATH}:~/doom-emacs/bin"
export PATH="${PATH}:${GOPATH}/bin"
export GOPATH="/home/blacksheep/.asdf/installs/golang/1.14.6/packages"
source <(kitty + complete setup bash)
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
