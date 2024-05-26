_:
{
  perSystem = { pkgs, ... }: {
    packages =
      rec {
        default = thesis;

        texLiveEnvironment = pkgs.texliveBasic.withPackages (import ./tex-packages.nix);

        texLiveDevEnvironment = pkgs.texliveBasic.withPackages (p: (import ./tex-packages.nix) p ++ [
          p.git-latexdiff
          p.latexdiff
          p.latexpand
          p.ulem
        ]);

        thesis = pkgs.stdenvNoCC.mkDerivation rec {
          name = "baka_projekt_grigorjan_põldsam_abiõpetaja_rakendus_matemaatika_töölehtede_loomiseks_sympy_abil";
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
            cp ./out/thesis.pdf $out/${name}.pdf
          '';
        };
      };
  };
}

