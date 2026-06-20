#!/bin/bash
# Bootstrap script for new machine setup

set -e

echo "🚀 zshular Bootstrap"
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

# 3a. Install MesloLGS NF (the Nerd Font powerlevel10k expects).
# theme.zsh sets POWERLEVEL9K_MODE=nerdfont-complete, which renders as broken
# glyphs (tofu) unless a Nerd Font is installed AND the terminal is set to use it.
echo ""
MESLO_DIR="$HOME/Library/Fonts"
if ls "$MESLO_DIR"/MesloLGS\ NF*.ttf >/dev/null 2>&1; then
  echo "✓ MesloLGS NF already installed"
else
  echo "Installing MesloLGS NF..."
  mkdir -p "$MESLO_DIR"
  base="https://github.com/romkatv/powerlevel10k-media/raw/master"
  for variant in "Regular" "Bold" "Italic" "Bold%20Italic"; do
    name="MesloLGS NF ${variant//\%20/ }.ttf"
    curl -fsSL "$base/MesloLGS%20NF%20$variant.ttf" -o "$MESLO_DIR/$name" \
      && echo "  ✓ $name" || echo "  ✗ failed: $name"
  done
  echo "  ⚠️  Set your terminal's font to 'MesloLGS NF' for icons to render."
fi

# 3b. Guard against a stray ~/.p10k.zsh.
# The prompt is defined ENTIRELY by inline POWERLEVEL9K_* vars in zsh/theme.zsh.
# A wizard-generated ~/.p10k.zsh (e.g. from running `p10k configure`) is a rival
# source of truth that will override the intended prompt. Do not run
# `p10k configure`; if a ~/.p10k.zsh exists, it is not used and can be removed.
echo ""
if [[ -f ~/.p10k.zsh ]]; then
  ts="$(date +%Y%m%d-%H%M%S)"
  mv ~/.p10k.zsh ~/.p10k.zsh.unused-$ts
  echo "⚠️  Found ~/.p10k.zsh (not used by zshular). Renamed to ~/.p10k.zsh.unused-$ts"
else
  echo "✓ No stray ~/.p10k.zsh (prompt is driven by zsh/theme.zsh)"
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

# 8. Install the minimal .zshrc loader
echo ""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f ~/.zshrc ]] && ! grep -q 'zshular/zsh' ~/.zshrc 2>/dev/null; then
  ts="$(date +%Y%m%d-%H%M%S)"
  cp ~/.zshrc ~/.zshrc.pre-zshular-$ts
  echo "✓ Backed up existing ~/.zshrc to ~/.zshrc.pre-zshular-$ts"
fi
if ! grep -q 'zshular/zsh' ~/.zshrc 2>/dev/null; then
  cp "$SCRIPT_DIR/zshrc.template" ~/.zshrc
  echo "✓ Installed minimal ~/.zshrc loader (from zshrc.template)"
else
  echo "✓ ~/.zshrc already sources zshular"
fi

echo ""
echo "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "1. Move secrets/machine-specific env vars to ~/.zsh-local/env.zsh"
echo "   (anything that used to live inline in your old .zshrc)"
echo "2. Set your terminal font to 'MesloLGS NF'"
echo "3. Do NOT run \`p10k configure\` — the prompt lives in zsh/theme.zsh"
echo "4. Restart your shell: exec zsh"
