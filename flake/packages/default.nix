_:
{
  perSystem = { pkgs, ... }: {
    packages =
      rec {
        default = thesis;

        texLiveEnvironment = pkgs.texliveBasic.withPackages (import ./tex-packages.nix);

        thesis = pkgs.stdenvNoCC.mkDerivation {
          name = "thesis";
          src = ../../src;

          nativeBuildInputs = [
            pkgs.biber
            texLiveEnvironment
          ];

          nativeCheckInputs = [
            (pkgs.hunspellWithDicts [
              pkgs.hunspellDicts.et_EE
              pkgs.hunspellDicts.en_US
            ])
          ];

          buildPhase = ''
            pdflatex thesis.tex
            biber thesis
            pdflatex thesis.tex
            pdflatex thesis.tex
          '';

          doCheck = true;

          checkPhase = ''
            export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
            export LANG="en_US.UTF-8"

            misspellings=$(find . -name "*.tex" | xargs hunspell -d et_EE,en_US -p spellcheck-ignore.txt -l)

            if [[ $misspellings ]]; then
                echo "Spellcheck failed, misspelled words:"
                echo "$misspellings"
                exit 1
            fi
          '';

          installPhase = ''
            mkdir -p $out
            cp thesis.pdf $out
          '';
        };
      };
  };
}

