default: check-bib spell build

check-bib:
    cd ./src && biber --tool --validate-datamodel references.bib


build:
    cd ./src && latexmk -pdf -output-directory="../out/" -interaction=nonstopmode -shell-escape -xelatex thesis.tex 

spell:
    ./spell.sh



