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
            (pkgs.hunspellWithDicts [ pkgs.hunspellDicts.et_EE ])
            (pkgs.texliveMinimal.withPackages (p: [ p.detex ]))
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

            detex thesis.tex > thesis_content.txt
            misspellings=$(hunspell -d et_EE -p spellcheck-ignore.txt -l thesis_content.txt)

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

