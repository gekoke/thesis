default: check build


check: bib spell

bib:
    cd ./src && biber --tool --validate-datamodel references.bib

spell:
    ./spell.sh


clean:
    rm -rf ./out ./src/_minted-thesis ./src/svg-inkscape
    cat .gitignore | xargs -I _ find -type f -name "_" -exec rm {} \;

build:
    cd ./src && latexmk -pdf -output-directory="../out/" -interaction=nonstopmode -shell-escape -xelatex thesis.tex 

cleanbuild: clean build



