## BSc Thesis 2024

### Building

#### With direnv
```sh
direnv allow
just
```

#### With Nix
```sh
nix build
```

Whichever tool you use, building also runs a spellcheck on the `.tex` files.

### Generating diff PDF document

```sh
direnv allow
cd src
git-latexdiff --biber --xelatex --latexopt -shell-escape --main thesis.tex -o diff.pdf OLDGITREV
```

