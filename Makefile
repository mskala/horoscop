PATH:=${PATH}:.

default:  horoscop.pdf

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

horoscop.pdf: horoscop.ps
	ps2pdf horoscop.ps
