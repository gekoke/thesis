default: check build


check: bib spell

bib:
    cd ./src && biber --tool --validate-datamodel references.bib

spell:
    ./spell.sh


build:
    cd ./src && latexmk -pdf -output-directory="../out/" -interaction=nonstopmode -shell-escape -xelatex thesis.tex 

