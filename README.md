# homebrew-mac-deploy

Homebrew tap for [mac-deploy](https://github.com/davidwhittington/mac-deploy) — macOS workstation security hardening and audit tools.

## Install

```bash
brew tap davidwhittington/mac-deploy
brew install mac-deploy
```

## What you get

| Command | What it does |
|---------|-------------|
| `mac-deploy-audit` | Full security posture audit — FileVault, SIP, Gatekeeper, Firewall, SSH, open ports |
| `mac-deploy-capture` | Snapshot current Homebrew packages and shell config |
| `mac-deploy-deploy` | Restore a saved machine profile to a new or rebuilt Mac |

## Quick start

```bash
# Run a quick audit (no package lists)
mac-deploy-audit --brief

# Full audit saved to file
mac-deploy-audit --save
```

## Full documentation

[davidwhittington.github.io/mac-deploy](https://davidwhittington.github.io/mac-deploy)
