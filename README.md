# Dotfiles

Personal dotfiles for easy sharing across machines with company-specific isolation.

## Features

- Modular zsh configuration (oh-my-zsh, powerlevel10k)
- Company-specific override pattern
- Secrets isolated from Git tracking
- Bootstrap script for new machines

## Directory Structure

```
~/dotfiles/              # Git tracked
├── zsh/
│   ├── oh-my-zsh.zsh   # Oh-my-zsh settings
│   ├── plugins.zsh     # Plugin configuration
│   ├── theme.zsh       # Powerlevel10k theme
│   ├── path.zsh        # PATH configuration
│   ├── aliases.zsh     # Shared aliases
│   └── functions.zsh   # Shared functions
└── bootstrap.sh         # New machine setup

~/.zsh-local/            # NOT tracked (local only)
├── env.zsh             # Machine/company-specific env vars
├── aliases-{co}.zsh    # Company-specific aliases
└── functions-{co}.zsh  # Company-specific functions
```

## New Machine Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   ```

2. Run bootstrap script:
   ```bash
   ~/dotfiles/bootstrap.sh
   ```

3. Replace `~/.zshrc` with loader:
   ```bash
   # Backup your current .zshrc if needed
   mv ~/.zshrc ~/.zshrc.backup

   # Create new minimal .zshrc (see docs/plans/2025-12-17-dotfiles-setup.md)
   ```

4. Restart shell:
   ```bash
   exec zsh
   ```

## Adding Company-Specific Config

Edit these files (not tracked by Git):
- `~/.zsh-local/env.zsh` - Environment variables
- `~/.zsh-local/aliases-{company}.zsh` - Aliases
- `~/.zsh-local/functions-{company}.zsh` - Functions

The system reads `~/.company` to determine which company configs to load.

## Security

**Never commit:**
- API keys
- Tokens
- SSH connection strings
- Company credentials

All secrets should go in `~/.zsh-local/env.zsh` (not tracked).

## Requirements

- Zsh
- Git
- Oh-my-zsh (installed by bootstrap)
- Powerlevel10k (installed by bootstrap)

## Future Expansion

This structure supports tracking other dotfiles:
- Git config: `~/dotfiles/git/`
- Ruby config: `~/dotfiles/ruby/`
- etc.
