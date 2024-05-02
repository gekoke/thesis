{ inputs, ... }:
{
  flake = {
    overlays.hunspellEstonianDict = final: prev: {
      hunspellDicts = prev.hunspellDicts // {
        et_EE = inputs.nixpkgs-hunspell-et-dict.legacyPackages.${prev.stdenv.hostPlatform.system}.hunspellDicts.et_EE;
        et-ee = final.hunspellDicts.et_EE;
      };
    };
  };
}
