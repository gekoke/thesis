build:
    mkdir -p out/{appendices,chapters,preamble}
    cd ./src && pdflatex -output-directory="../out/" thesis.tex
    cd ./src && biber --output-directory="../out/" thesis
    cd ./src && pdflatex -output-directory="../out/" thesis.tex
    cd ./src && pdflatex -output-directory="../out/" thesis.tex

spell:
    ./spell.sh



