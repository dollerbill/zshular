#!/bin/bash
# Bootstrap script for new machine setup

set -e

echo "🚀 Dotfiles Bootstrap"
echo ""

# 1. Install oh-my-zsh if needed
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "✓ oh-my-zsh installed"
else
  echo "✓ oh-my-zsh already installed"
fi

# 2. Install oh-my-zsh plugins
echo ""
echo "Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  echo "✓ zsh-autosuggestions installed"
else
  echo "✓ zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  echo "✓ zsh-syntax-highlighting installed"
else
  echo "✓ zsh-syntax-highlighting already installed"
fi

# evalcache
if [[ ! -d "$ZSH_CUSTOM/plugins/evalcache" ]]; then
  git clone https://github.com/mroth/evalcache "$ZSH_CUSTOM/plugins/evalcache"
  echo "✓ evalcache installed"
else
  echo "✓ evalcache already installed"
fi

# 3. Install powerlevel10k theme
echo ""
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  echo "Installing powerlevel10k..."
  git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
  echo "✓ powerlevel10k installed"
else
  echo "✓ powerlevel10k already installed"
fi

# 4. Create .zsh-local directory
echo ""
mkdir -p ~/.zsh-local
echo "✓ Created ~/.zsh-local directory"

# 5. Prompt for company setup
echo ""
echo "Company/Environment Setup"
echo "------------------------"
read -p "Company/environment name (e.g., 'personal', 'cognoa'): " company

if [[ -z "$company" ]]; then
  company="personal"
fi

echo "$company" > ~/.company
echo "✓ Created ~/.company with value: $company"

# 6. Create empty company-specific config files
touch ~/.zsh-local/env.zsh
touch ~/.zsh-local/aliases-$company.zsh
touch ~/.zsh-local/functions-$company.zsh

echo "✓ Created company-specific config files:"
echo "  - ~/.zsh-local/env.zsh"
echo "  - ~/.zsh-local/aliases-$company.zsh"
echo "  - ~/.zsh-local/functions-$company.zsh"

# 7. Add .zsh-local to global gitignore if not already there
if [[ ! -f ~/.gitignore_global ]]; then
  touch ~/.gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
  echo "✓ Created ~/.gitignore_global and configured Git"
fi

if ! grep -q ".zsh-local/" ~/.gitignore_global 2>/dev/null; then
  echo ".zsh-local/" >> ~/.gitignore_global
  echo "✓ Added .zsh-local/ to ~/.gitignore_global"
fi

echo ""
echo "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "1. Edit your ~/.zshrc to source from ~/dotfiles/zsh/"
echo "2. Move your existing config to modular files in ~/dotfiles/zsh/"
echo "3. Move secrets to ~/.zsh-local/env.zsh"
echo "4. Restart your shell: exec zsh"
