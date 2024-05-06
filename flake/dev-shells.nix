{ self, ... }:
{
  perSystem = { pkgs, system, ... }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        packages = [
          pkgs.biber
          pkgs.just
          pkgs.inkscape
          pkgs.python3Packages.pygments
          self.packages.${system}.texLiveEnvironment
          (pkgs.hunspellWithDicts [
            pkgs.hunspellDicts.et_EE
            pkgs.hunspellDicts.en_US
          ])
        ];
      };
    };
  };
}
