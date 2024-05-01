## BSc Thesis 2024

### Building

#### With TeX Live
```sh
cd src
pdflatex thesis.tex
biber thesis
pdflatex thesis.tex
pdflatex thesis.tex
```

#### With Nix
```sh
nix build
```

