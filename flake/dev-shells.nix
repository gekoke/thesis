{ self, ... }:
{
  perSystem = { pkgs, system, ... }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        packages = [
          self.packages.${system}.texLiveEnvironment
          (pkgs.hunspellWithDicts [ pkgs.hunspellDicts.et_EE ])
        ];
      };
    };
  };
}
