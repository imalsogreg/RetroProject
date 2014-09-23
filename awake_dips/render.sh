pandoc outline.md -o outline.html
pandoc --template=plos.tex --csl=plos.csl --bibliography=theta.bib awake-dips.md awake-dips.pdf
