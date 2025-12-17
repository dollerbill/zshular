# Shared PATH configuration

# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
