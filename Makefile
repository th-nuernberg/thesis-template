DOC=document
EXPOSE=expose/expose
LATEX=pdflatex -shell-escape

.SUFFIXES:
.SUFFIXES: .bib .pdf .tex
.PHONY: clean expose

run: $(DOC).pdf

expose: $(EXPOSE).pdf

$(EXPOSE).pdf: $(EXPOSE).bbl $(EXPOSE).tex
	cd expose && $(LATEX) expose.tex -draftmode
	cd expose && $(LATEX) expose.tex

$(EXPOSE).bbl: $(EXPOSE).aux
	cd expose && BIBINPUTS=.. bibtex expose.aux

$(EXPOSE).aux: refs.bib
	cd expose && $(LATEX) expose.tex -draftmode
	cd expose && $(LATEX) expose.tex -draftmode

$(DOC).pdf: $(DOC).bbl $(DOC).tex
	$(LATEX) $(DOC).tex -draftmode
	$(LATEX) $(DOC).tex

$(DOC).bbl: $(DOC).aux
	bibtex $(DOC).aux

$(DOC).aux: refs.bib
	$(LATEX) $(DOC).tex -draftmode
	$(LATEX) $(DOC).tex -draftmode

clean:
	rm -f {.,content,expose}/*.{aux,lof,log,lot,lol,bcf,toc,bbl,blg,run.xml,out,brf,fdb_latexmk,synctex,fls,xmpdata,xmpi}
