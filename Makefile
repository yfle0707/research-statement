#
# $Id: Makefile,v 1.1 2006/06/27 21:10:04 shafer Exp $
#
# Makefile for converting tex files to PDF
#

all: research-statement.pdf

#
# We want our main "pdf" to depend on all the "tex" and "bib" source
#

#paper.pdf: sig-alternate-10pt.cls *.tex *.bib figures/*
#paper.pdf: acmart.cls *.tex *.bib figures/*

paper.pdf: *.tex *.bib 
#
# Now provide the rules for building the various targets and
# intermediate targets
#

%.pdf : %.tex
	pdflatex $<
	bibtex --min-crossrefs=1000 $*
	pdflatex $<
	pdflatex $<

%.ps : %.dvi
	dvips -Ppdf -Pcmz -Pamz -t letter -D 600 -G0 -j0 -o $@ $<

# %.pdf : %.ps
# 	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -dCompatibilityLevel=1.2 -dProcessColorModel=/DeviceGray -dSubsetFonts=true -dMaxSubsetPct=100 $< $@

clean:
	-rm -f *.dvi *.log *.aux *.bbl *.blg *.ent *.out research-statement.pdf

#
# Run "make balance" after adding balance columns at the right place
#

balance:
	latex paper
	latex paper
	dvips -o paper.ps paper.dvi
	ps2pdf paper.ps paper.pdf
