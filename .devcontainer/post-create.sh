#!/usr/bin/env bash
# Runs once after the container is created. Installs the Nix toolset and beans.
set -euo pipefail
cd "$(dirname "$0")/.."

# Workspace is bind-mounted from the host; allow git to operate on it.
git config --global --add safe.directory "$PWD"

# Tools pinned by flake.nix (git, gh, go-task, go, markdownlint, rapper, ...).
nix profile add .#tools

# beans (https://github.com/hmans/beans) is not packaged in nixpkgs, so it is
# built from source with the Nix-provided Go (CGO disabled: no C compiler in the image). Pinned to a released version for
# reproducibility; update BEANS_VERSION deliberately.
BEANS_VERSION=v0.4.2
CGO_ENABLED=0 go install "github.com/hmans/beans@${BEANS_VERSION}"

echo "Done. Next: git config --global user.name/user.email (see .devcontainer/README.md)."
