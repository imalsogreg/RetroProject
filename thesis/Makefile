
build/thesis.pdf: thesis.org render.hs preamble.tex thesisTemplate.latex
	runhaskell render.hs

build/index.html: defense.md revealTemplate.html slides.css
	pandoc -t revealjs defense.md -s --slide-level 1 --template revealTemplate.html -o build/index.html



