_:
{
  perSystem = { pkgs, ... }: {
    packages =
      rec {
        default = thesis;

        texLiveEnvironment = pkgs.texliveBasic.withPackages (p: [
          p.etoolbox
          p.babel-estonian
        ]);

        thesis = pkgs.stdenv.mkDerivation {
          name = "thesis";
          src = ../.;

          nativeBuildInputs = [
            texLiveEnvironment
          ];

          nativeCheckInputs = [
            (pkgs.hunspellWithDicts [ pkgs.hunspellDicts.et_EE ])
          ];

          buildPhase = ''
            pdflatex thesis.tex
          '';

          doCheck = true;

          checkPhase = ''
            export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
            export LANG="en_US.UTF-8"

            misspellings=$(hunspell -d et_EE -p spellcheck-allow.txt -t -l thesis.tex)

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

