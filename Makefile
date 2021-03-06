#for dependency you want all tex files  but for acronyms you do not want to include the acronyms file itself.
tex=$(filter-out $(wildcard *acronyms.tex aglossary.tex)  , $(wildcard *.tex))  


DOC= DMTN-115
SRC= $(DOC).tex

OBJ=$(SRC:.tex=.pdf)

#Default when you type make

$(OBJ): $(tex) acronyms.tex
	latexmk -bibtex -xelatex -f $(SRC)
	makeglossaries $(DOC)
	xelatex  $(SRC)


#The generateAcronyms.py  script is in lsst-texmf/bin - put that in the path
acronyms.tex :$(tex) myacronyms.txt
	generateAcronyms.py   $(tex)

aglossary.tex :$(tex) myacronyms.txt
	generateAcronyms.py -t "Petabytes DM"  -g aglossary.tex $(tex)
clean :
	latexmk -c
	rm *.pdf *.nav *.bbl *.xdv *.snm



