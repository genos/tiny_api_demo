{
  description = "Tiny API Demo";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      py = pkgs.python310.withPackages (p: [p.flask]);
    in {
      packages.default = pkgs.writeShellApplication {
        name = "tiny_api_demo";
        text = ''
          FLASK_APP=app.py ${py}/bin/python -m flask run
        '';
      };
    });
}
