#!/bin/bash

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "run_once_install-tmux.sh only supports macOS." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required to install tmux." >&2
  exit 1
fi

if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  brew install tmux
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing tpm..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

if [ -x "$TPM_DIR/bin/install_plugins" ]; then
  echo "Installing tmux plugins from ~/.tmux.conf..."
  "$TPM_DIR/bin/install_plugins"
fi
