{
  description = "Tooling for editing Markdown, OWL and SKOS in the sona dev container";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      forAll = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ]
        (system: f nixpkgs.legacyPackages.${system});
    in {
      packages = forAll (pkgs: {
        tools = pkgs.buildEnv {
          name = "sona-tools";
          paths = with pkgs; [
            git               # version control
            gh                # GitHub CLI (auth, PRs)
            go-task           # Taskfile runner ("task")
            go                # used to build beans (not packaged in nixpkgs)
            markdownlint-cli2 # Markdown linting (task lint:md)
            librdf_raptor2    # provides "rapper" to validate OWL/SKOS/RDF (task validate:rdf)
            nixpkgs-fmt       # formatting for flake.nix
          ];
        };
        default = self.packages.${pkgs.system}.tools;
      });
      devShells = forAll (pkgs: {
        default = pkgs.mkShell { packages = [ self.packages.${pkgs.system}.tools ]; };
      });
    };
}
