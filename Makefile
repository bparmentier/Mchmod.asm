#NOM    : makefile
#CLASSE : FS - FS078
#OBJET  : rapport du projet FS078
#HOWTO	: make; make clean
#AUTEUR	: Bruno Parmentier, 02/2014

Affichage: FS078.ps
	gv FS078.ps --scale=2
	rm -f *.aux *.dvi *.idx *.log *.toc *~

FS078.ps: FS078.dvi
	dvips FS078.dvi -o FS078.ps

FS078.dvi: FS078.tex
	latex FS078.tex
	#latex FS078.tex	# 2x pour la T.O.C.

clean:
	rm -f *.aux *.dvi *.idx *.log *.toc *~ 
	find . -name *~ -exec rm -f '{}' \;
	find . -name *.o -exec rm -f '{}' \;
	find . -name *.bak -exec rm -f '{}' \;
