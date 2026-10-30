#!/usr/bin/env bash
# Runs once after the container is created. Installs the Nix toolset.
set -euo pipefail
cd "$(dirname "$0")/.."

# Workspace is bind-mounted from the host; allow git to operate on it.
git config --global --add safe.directory "$PWD"

# Tools pinned by flake.nix (git, gh, go-task, markdownlint, rapper, ...).
nix profile add .#tools

echo "Done. Next: git config --global user.name/user.email (see .devcontainer/README.md)."
