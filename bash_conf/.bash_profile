#!/bin/bash
export PATH="${PATH}:/$HOME/.local/bin:/usr/local/bin:/$HOME/.local/share/bin:/$HOME/.npm-global/bin:/$HOME/.config/yarn/global"

if [ -d "$HOME/.asdf" ]; then
  source "$HOME/.asdf/asdf.bash"
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  GOPATH=$(asdf where golang)
  export GOPATH
  export GO111MODULE=on
  export GOBIN="${GOPATH}/bin"

  export PATH="${PATH}:${GOPATH}:${GOBIN}"
  RUSTPATH=$(asdf where rust)
  export RUSTPATH
  export CARGO_NET_GIT_FETCH_WITH_CLI=true
fi

export EDITOR=nvim

if [ -f ~/.bash_aliases ]; then
  . "$HOME/.bash_aliases"
fi

if [ -f ~/.bashlib ]; then
  . "$HOME/.bashlib"
fi

if [ -f ~/.bash_docker ]; then
  . "$HOME/.bash_docker"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if [ -f "$HOME/.bash_prompt" ]; then
  . "$HOME/.bash_prompt"
fi

if [ -f "$HOME/.bash_py" ]; then
  . "$HOME/.bash_py"
fi

if [ -f "$HOME/.bash_twig" ]; then
  . "$HOME/.bash_twig"
fi

if [ -d "$HOME/.local/share/nvim/mason/bin" ]; then
  export PATH="${PATH}:$HOME/.local/share/nvim/mason/bin"
fi

if [ -d /home/linuxbrew ]; then
  export PATH="${PATH}:/home/linuxbrew/.linuxbrew/bin"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export ERL_AFLAGS="-kernel shell_history enabled"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
source /usr/share/bash-completion/completions/git

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_RESULTS=50
export MCFLY_KEY_SCHEME=vim
eval "$(mcfly init bash)"

LV2_PATH=/usr/lib/x86_64-linux-gnu/lv2:$LV2_PATH
export LV2_PATH
