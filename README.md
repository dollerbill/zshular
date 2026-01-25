# zshular

Modular zsh configuration for easy sharing across machines with company-specific isolation.

## Features

- Modular zsh configuration (oh-my-zsh, powerlevel10k)
- Company-specific override pattern
- Secrets isolated from Git tracking
- Bootstrap script for new machines

## Directory Structure

```
~/zshular/             # Git tracked
├── zsh/
│   ├── oh-my-zsh.zsh   # Oh-my-zsh settings
│   ├── plugins.zsh     # Plugin configuration
│   ├── theme.zsh       # Powerlevel10k theme
│   ├── path.zsh        # PATH modifications (homebrew, rbenv, nvm)
│   ├── aliases.zsh     # Shared aliases
│   └── functions.zsh   # Shared functions
└── bootstrap.sh        # New machine setup

~/.zsh-local/           # NOT tracked (local only)
├── env.zsh             # Machine/company-specific env vars
├── aliases-{co}.zsh    # Company-specific aliases
├── functions-{co}.zsh  # Company-specific functions
└── projects/           # Project-specific configs
    └── *.zsh           # Auto-loaded project configs
```

## New Machine Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/zshular
   ```

2. Run bootstrap script:
   ```bash
   ~/zshular/bootstrap.sh
   ```

3. Replace `~/.zshrc` with loader:
   ```bash
   # Backup your current .zshrc if needed
   mv ~/.zshrc ~/.zshrc.backup

   # Create new minimal .zshrc
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

## Adding Project-Specific Config

Create project-specific files in `~/.zsh-local/projects/`:
```bash
# Example: Create tuxedo project config
echo "alias tux-deploy='...'" > ~/.zsh-local/projects/tuxedo.zsh
```

All `.zsh` files in the `projects/` directory are automatically loaded.

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
- Git config: `~/zshular/git/`
- Ruby config: `~/zshular/ruby/`
- etc.

  📝 Common Tasks

  Add a new shared alias

  echo "alias myalias='some command'" >> ~/zshular/zsh/aliases.zsh
  git -C ~/zshular add zsh/aliases.zsh
  git -C ~/zshular commit -m "add: myalias"
  git -C ~/zshular push

  Add a company-specific alias

  echo "alias cognoa-deploy='ssh production'" >> ~/.zsh-local/aliases-cognoa.zsh
  # No git commit - this stays local!

  Add a project-specific alias

  echo "alias tux-deploy='ssh tuxedo-prod'" >> ~/.zsh-local/projects/tuxedo.zsh
  # Auto-loaded, not tracked by git

  Add a secret/token

  echo "export MY_API_KEY='secret123'" >> ~/.zsh-local/env.zsh
  # Never commit this!

  Setup on a new machine

  git clone <your-repo-url> ~/zshular
  ~/zshular/bootstrap.sh  # Installs oh-my-zsh, plugins, theme
  # Copy the minimal .zshrc (it's not in the repo)
  # Create ~/.zsh-local/env.zsh with machine-specific vars
  exec zsh

  ---
