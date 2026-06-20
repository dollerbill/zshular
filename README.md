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
├── zshrc.template      # Minimal ~/.zshrc loader (installed by bootstrap)
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
   This installs oh-my-zsh + plugins + powerlevel10k, installs the **MesloLGS NF**
   font, backs up any existing `~/.zshrc`, installs the minimal loader from
   `zshrc.template`, and renames any stray `~/.p10k.zsh` (see Prompt / Powerlevel10k).

3. Set your terminal font to **MesloLGS NF** (Terminal/iTerm/Ghostty preferences).

4. Move machine-specific env vars and secrets into `~/.zsh-local/env.zsh`.

5. Restart shell:
   ```bash
   exec zsh
   ```

## Prompt / Powerlevel10k

**The prompt is defined entirely by inline `POWERLEVEL9K_*` variables in
`zsh/theme.zsh`** (tracked). This is the single source of truth.

- **Do NOT run `p10k configure`.** It generates a `~/.p10k.zsh` (the stock
  rainbow template) that becomes a rival config. `theme.zsh` deliberately does
  **not** source `~/.p10k.zsh`; if you create one, it is simply unused — and if
  it ever gets sourced, it overrides and breaks the intended prompt.
- `bootstrap.sh` renames any pre-existing `~/.p10k.zsh` out of the way.
- The prompt requires a **Nerd Font**: `oh-my-zsh.zsh` sets
  `POWERLEVEL9K_MODE='nerdfont-complete'`, so without **MesloLGS NF** installed
  *and* selected as the terminal font, icons render as tofu/wrong glyphs.
- To change the prompt, edit `zsh/theme.zsh` and commit — never via the wizard.

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
- A Nerd Font — **MesloLGS NF** (installed by bootstrap), set as the terminal font

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
  ~/zshular/bootstrap.sh  # Installs oh-my-zsh, plugins, theme, MesloLGS NF,
                          # and the minimal ~/.zshrc loader (from zshrc.template)
  # Set terminal font to MesloLGS NF
  # Create ~/.zsh-local/env.zsh with machine-specific vars
  exec zsh

  ---
