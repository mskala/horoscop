PATH:=${PATH}:.

default: horoscop.zip

horoscop.sty: horoscop.ins horoscop.dtx
	rm -f horoscop.sty
	latex horoscop.ins

horoscop.ps: horoscop.dvi
	dvips horoscop.dvi -o

horoscop.dvi: horoscop.dtx horoscop.sty
	latex --shell-escape horoscop.dtx
	makeindex -s gglo.ist -o horoscop.gls horoscop.glo
	makeindex -s gind.ist -o horoscop.ind horoscop.idx
	latex --shell-escape horoscop.dtx

# horoscop.pdf: horoscop.ps
# 	ps2pdf horoscop.ps

horoscop.pdf: horoscop.dtx horoscop.sty
	pdflatex --shell-escape horoscop.dtx
	makeindex -s gglo.ist -o horoscop.gls horoscop.glo
	makeindex -s gind.ist -o horoscop.ind horoscop.idx
	pdflatex --shell-escape horoscop.dtx

horoscop.zip: README horoscop.ins horoscop.dtx horoscop.pdf
	rm -f horoscop.zip
	mkdir horoscop
	cp README horoscop.ins horoscop.dtx horoscop.pdf horoscop
	zip -r horoscop.zip horoscop
	rm -rf horoscop
