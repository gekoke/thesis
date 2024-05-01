{ inputs, ... }:
{
  flake = {
    overlays.hunspellEstonianDict = final: prev: rec {
      hunspellDicts.et_EE = inputs.nixpkgs-hunspell-et-dict.legacyPackages.${prev.stdenv.hostPlatform.system}.hunspellDicts.et_EE;
      hunspellDicts.et-ee = hunspellDicts.et_EE;
    };
  };
}
