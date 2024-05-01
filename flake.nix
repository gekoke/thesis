{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-hunspell-et-dict.url = "github:gekoke/nixpkgs/1d261ca49aa0efee846c660a01358d66fa2c12d1";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: import ./flake inputs;
}
