{ flake-parts
, self
, ...
} @ inputs:
flake-parts.lib.mkFlake { inherit inputs; } {
  systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

  imports = [
    ./dev-shells.nix
    ./packages
    ./overlays.nix
    {
      perSystem = { system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ self.overlays.hunspellEstonianDict ];
        };
      };
    }
  ];
}

