# Zsh plugins configuration

# Oh-my-zsh plugins (loaded by oh-my-zsh)
plugins=(
  evalcache
  git
  bundler
  macos
  rails
  rake
  ruby
)

# Custom plugins (loaded manually after oh-my-zsh)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Source custom plugins if they exist
if [[ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
