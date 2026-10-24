# sona dev container

A Nix-based dev container for editing Markdown, OWL and SKOS in VS Code with
Git/GitHub, Copilot, [Task](https://taskfile.dev) and
[Beans](https://github.com/hmans/beans), run with **rootless Podman**.

## Workflow

1. One-off host setup: install Podman and set VS Code setting
   `dev.containers.dockerPath` to `podman`.
2. In VS Code: *Git: Clone* (from GitHub) the repository.
3. *Dev Containers: Reopen in Container*. The first build takes a few minutes.
4. After the first creation only, set your git identity in the container terminal:

   ```sh
   git config --global user.name "Your Name"
   git config --global user.email "you@example.com"
   ```

5. Edit, then run `task check` before committing. Use `beans` (CLI / extension)
   to hand tasks to and from Copilot; beans are stored in the repo (`.beans`).

## Files

| File | Purpose |
| --- | --- |
| `Containerfile` | Debian 13 (trixie) slim base + single-user Nix owned by `vscode` |
| `devcontainer.json` | Podman/permission settings, extensions, settings |
| `post-create.sh` | Installs Nix tools from `../flake.nix` and builds `beans` with Go |
| `../flake.nix` | Tool set: git, gh, go-task, go, markdownlint-cli2, raptor2 (`rapper`) |
| `../Taskfile.yml` | `task lint:md`, `task validate:rdf`, `task check` |

## Permissions

Rootless Podman maps your host user to root in the container by default, which
makes bind-mounted files unwritable by the `vscode` user. We pass
`--userns=keep-id:uid=1000,gid=1000` and run as `vscode` (UID 1000), so files
are owned by you on both sides and saving/committing works. This assumes your
host UID is 1000 (check `id -u`); otherwise change the `uid`/`gid` values in
`devcontainer.json` and the user ID in the `Containerfile`. The workspace mount
uses `z=true` so SELinux hosts allow access. Nix runs in single-user mode, so
no root or daemon is needed.

## Credentials

- No host directories such as `~/.ssh` or `~/.config/gh` are mounted and no
  tokens are stored in the image or repo.
- VS Code forwards your host git credential helper and SSH agent into the
  container on demand; GitHub/Copilot sign-in is done through VS Code.
- Never commit secrets; `.gitignore` covers common local files.

## Extensions

| Extension | Why |
| --- | --- |
| GitHub.copilot, GitHub.copilot-chat | AI assistance |
| GitHub.vscode-pull-request-github | PRs/issues from VS Code |
| task.vscode-task | Run Taskfile tasks |
| selfagency.beans-vscode | Beans task management |
| yzhang.markdown-all-in-one, DavidAnson.vscode-markdownlint | Markdown editing and linting |
| stardog-union.stardog-rdf-grammars, stardog-union.vscode-langserver-turtle | Turtle/RDF syntax and language server (SKOS/OWL in Turtle) |
| redhat.vscode-xml | RDF/XML OWL files |
| jnoortheen.nix-ide | Editing `flake.nix` |

Git tooling is deliberately kept minimal (no GitLens) in case of a future move
away from git. `beans` is pinned to a released version in `post-create.sh`.

## Why `.owl`/`.rdf` are associated with XML

`.owl` and `.rdf` files are conventionally RDF/XML, so VS Code uses the XML
language service for them. This is only a default for editor support, not a
requirement: Turtle (`.ttl`) is supported too and is easier to read and diff.
If you maintain the ontology in Turtle, use `.ttl` and remove the `*.owl` and
`*.rdf` associations in `devcontainer.json`.

## Why not just `"remoteUser": "root"`?

That is root *inside* the container only (with rootless Podman it maps to your
host user), so it is a legitimate fallback if `keep-id` doesn't work. Downsides:
files created in the workspace may be owned by a different/subuid on the host
depending on the setup, tools and Nix would then be installed under `/root`,
any process or extension runs with full container privileges, and a container
escape would be more serious on a rootful engine. The `vscode` user is the
safer default.
