# Shared aliases

# Add your shared aliases here
# Example:
# alias ll='ls -alh'
# alias g='git'

# Search
alias hgrep="history|grep"
alias ag "ag --pager less --color-line-number '1;34'"

alias ohmyzsh="source ~/.zshrc"
alias zshcolor="getColorCode background"

# git
alias amend="git commit --amend --no-edit"
alias force="git push --force"
alias status="git status"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Linters
alias goodcop="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop --parallel"
alias goodprettier="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.js$' | xargs prettier -c"
alias badcop="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop -a"
alias badprettier="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.js$' | xargs prettier -w"
alias gooderb="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.erb$' | xargs erb_lint"
alias baderb="git ls-files -m | xargs ls -1 2>/dev/null | grep '\.erb$' | xargs erb_lint -a"

# Database tools
alias reset='cc && be rake db:test:prepare RAILS_ENV=test'
 
alias be='bundle exec'
alias brake='bundle exec rake'
alias ber='bundle exec rspec'
alias skclear='Sidekiq::ScheduledSet.new.clear'
alias rs="bin/rails server -p 3000 -b 0.0.0.0"

alias rbv="rbenv"

# Misc
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias alreadyinuse="lsof -wni tcp:3001"
