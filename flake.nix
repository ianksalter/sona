{
  description = "Tooling for editing Markdown, OWL and SKOS in the sona dev container";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs }:
    let
      forAll = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ]
        (system: f nixpkgs.legacyPackages.${system});
    in {
      packages = forAll (pkgs: {
        tools = pkgs.buildEnv {
          name = "sona-tools";
          paths = with pkgs; [ git gh go-task go markdownlint-cli2 raptor2 nixpkgs-fmt ];
        };
        default = self.packages.${pkgs.system}.tools;
      });
      devShells = forAll (pkgs: {
        default = pkgs.mkShell { packages = [ self.packages.${pkgs.system}.tools ]; };
      });
    };
}
