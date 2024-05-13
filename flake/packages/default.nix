_:
{
  perSystem = { pkgs, ... }: {
    packages =
      rec {
        default = thesis;

        texLiveEnvironment = pkgs.texliveBasic.withPackages (import ./tex-packages.nix);

        thesis = pkgs.stdenvNoCC.mkDerivation {
          name = "grigorjan-poldsam-2024-bsc-thesis";
          src = ../../.;

          nativeBuildInputs = [
            pkgs.biber
            pkgs.just
            pkgs.inkscape
            pkgs.python3Packages.pygments
            texLiveEnvironment
          ];

          nativeCheckInputs = [
            (pkgs.hunspellWithDicts [
              pkgs.hunspellDicts.et_EE
              pkgs.hunspellDicts.en_US
            ])
          ];

          buildPhase = "just build";

          doCheck = true;

          checkPhase = ''
            export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
            export LANG="en_US.UTF-8"
            just check
          '';

          installPhase = ''
            mkdir -p $out
            cp ./out/thesis.pdf $out/grigorjan-põldsam-2024-bakalaureusetöö.pdf
          '';
        };
      };
  };
}

