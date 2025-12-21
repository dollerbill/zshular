# Oh-my-zsh core configuration
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
DISABLE_UPDATE_PROMPT=true

# Powerlevel10k mode (must be set before theme loads)
POWERLEVEL9K_MODE='nerdfont-complete'

# Plugins (must be set before oh-my-zsh.sh loads)
plugins=(
  evalcache
  git
  bundler
  macos
  rails
  rake
  ruby
)
