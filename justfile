default: spell build

build:
    cd ./src && latexmk -pdf -output-directory="../out/" -interaction=nonstopmode -shell-escape -xelatex thesis.tex 

spell:
    ./spell.sh


