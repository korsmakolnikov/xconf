#!/bin/bash

export GOPATH=`asdf where golang`
export GOBIN="${GOPATH}/bin"
export RUSTPATH=`asdf where rust` 
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export EDITOR=vim
export ELSP="$HOME/.elsp-1.11.2-otp-23"
PATH="${PATH}:/usr/local/bin:~/.local/bin"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

if [ -f $HOME/.asdf/asdf.sh  ]; then
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
fi

if [ -d $HOME/.asdf/installs ]; then
  PATH="${PATH}:$RUSTPATH:$RUSTPATH/bin"
fi
if [ -f /opt/asdf-vm/bin/asdf ]; then
  export PATH="${PATH}:/opt/asdf-vm/bin/"
  . /opt/asdf-vm/asdf.sh
  . /usr/share/bash-completion/completions/asdf
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
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

export EDITOR="vim"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="${PATH}:~/elm-language-server;~/.els"
export PATH="${PATH}:/home/blacksheep/.local/share/bin"
export PATH="${PATH}:/snap/bin"
export PATH="${PATH}:${ELSP}"
export PATH="${PATH}:${GOPATH}:${GOBIN}"
source <(kitty + complete setup bash)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
source /usr/share/bash-completion/completions/git
