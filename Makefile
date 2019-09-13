SHELL=/bin/bash
THESIS=thesis

.SUFFIXES:
.SUFFIXES: .bib .pdf .tex
.PHONY: clean

run: $(THESIS).pdf

$(THESIS).pdf: $(THESIS).bbl $(THESIS).tex
	pdflatex $(THESIS).tex -draftmode
	pdflatex $(THESIS).tex 

$(THESIS).bbl: $(THESIS).aux
	bibtex $(THESIS).aux

$(THESIS).aux: $(THESIS).bib
	pdflatex $(THESIS).tex -draftmode
	pdflatex $(THESIS).tex -draftmode

clean:
	rm -f *.{aux,lof,log,lot,lol,,bcf,toc,bbl,blg,pdf,run.xml,out}
	rm -f content/*.{aux,lof,log,lot,lol,,bcf,toc,bbl,blg,pdf,run.xml,out}