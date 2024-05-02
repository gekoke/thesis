{ self, ... }:
{
  perSystem = { pkgs, system, ... }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        packages = [
          pkgs.biber
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
