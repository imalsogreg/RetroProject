build/thesis.pdf: thesis.org render.hs preamble.tex thesisTemplate.latex
	runhaskell render.hs

build/index.html: defense.org
	pandoc -t revealjs defense.org -s --slide-level 3 -o build/index.html
