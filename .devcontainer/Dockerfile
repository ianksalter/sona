# Base: Debian-based dev container image (provides the non-root "vscode" user, UID 1000).
# Nix is installed on top and provides all project tools (see ../flake.nix).
FROM mcr.microsoft.com/devcontainers/base:bookworm

ARG NIX_INSTALLER=https://nixos.org/nix/install

# Single-user Nix owned by "vscode": no daemon, so no root needed at run time.
RUN apt-get update \
 && apt-get install -y --no-install-recommends xz-utils curl ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -m 0755 /nix && chown vscode:vscode /nix

USER vscode
RUN curl -fsSL "$NIX_INSTALLER" | sh -s -- --no-daemon \
 && mkdir -p ~/.config/nix \
 && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf \
 && echo '. ~/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc
ENV PATH=/home/vscode/.nix-profile/bin:/home/vscode/go/bin:$PATH
