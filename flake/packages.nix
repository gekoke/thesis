_:
{
  perSystem = { pkgs, system, ... }: {
    packages = rec {
      default = thesis;

      thesis = pkgs.stdenvNoCC.mkDerivation {
        name = "thesis";
        src = ../.;

        nativeBuildInputs = [
          pkgs.texliveFull
        ];

        buildPhase = ''
          pdflatex thesis.tex
        '';
        
        installPhase = ''
          mkdir -p $out/
          cp thesis.pdf $out/
        '';
      };
    };
  };
}

