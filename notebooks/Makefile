NOTEBOOKS = $(shell git ls-files [0-9]*)

all: book

include Makefile.style2

NBNORMFLAGS = -l1 -s2 -t h1 -L License -S 'HTML\('
include Makefile.norm

include Makefile.book
