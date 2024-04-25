
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
. "$HOME/.cargo/env"

alias py="python3"
alias cat="bat"
alias rgf='rg --files | rg'
alias ll='ls -la'
alias dockerip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

export STARSHIP_CONFIG=$HOME/.config/coderv2/dotfiles/starship.toml

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
