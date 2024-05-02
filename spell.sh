misspellings=$(find . -name "*.tex" | xargs hunspell -d et_EE,en_US -p spellcheck-ignore.txt -l)

if [[ $misspellings ]]; then
    echo "Spellcheck failed, misspelled words:"
    echo "$misspellings"
    exit 1
else
    echo "No spelling errors found"
fi

