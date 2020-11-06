#!/bin/bash
export PATH="${PATH}:/home/blacksheep/.local/bin:/usr/local/bin:/home/blacksheep/.local/share/bin:/home/blacksheep/.npm-global/bin"
if [ -f /opt/asdf-vm/bin/asdf ]; then
  export PATH="${PATH}:/opt/asdf-vm/bin/"
  . /opt/asdf-vm/asdf.sh
  . /usr/share/bash-completion/completions/asdf
fi

if [ -f $HOME/.asdf/asdf.sh  ]; then
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
fi

export GOPATH=`asdf where golang`
export GO111MODULE=on
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOPATH}:${GOBIN}"
export RUSTPATH=`asdf where rust` 
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export EDITOR=nvim
export PATH="${PATH}:/home/blacksheep/.local/bin:/usr/local/bin:/home/blacksheep/.local/share/bin:/home/blacksheep/.npm-global/bin:/home/blacksheep/.config/yarn/global"
export PATH="${PATH}:${GOPATH}:${GOBIN}"

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

if [ -d $HOME/.asdf/installs ]; then
  PATH="${PATH}:$RUSTPATH:$RUSTPATH/bin"
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

if [ -d $HOME/.local/share/nvim/mason/bin ]; then
  export PATH="${PATH}:$HOME/.local/share/nvim/mason/bin"
fi

if [ -d /home/linuxbrew ]; then
  export PATH="${PATH}:/home/linuxbrew/.linuxbrew/bin"
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export ERL_AFLAGS="-kernel shell_history enabled"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
source /usr/share/bash-completion/completions/git
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
eval "$(mcfly init bash)"

LV2_PATH=/usr/lib/x86_64-linux-gnu/lv2:$LV2_PATH
export LV2_PATH

