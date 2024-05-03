default: spell build

build:
    mkdir -p out/{appendices,chapters,preamble}
    cd ./src && pdflatex -interaction=nonstopmode -output-directory="../out/" thesis.tex
    cd ./src && biber --output-directory="../out/" thesis
    cd ./src && pdflatex -interaction=nonstopmode -output-directory="../out/" thesis.tex
    cd ./src && pdflatex -interaction=nonstopmode -output-directory="../out/" thesis.tex

spell:
    ./spell.sh


