.SUFFIXES: .beam .erl
.PHONY: default clean test proper

PROPER_PATH = /path/to/proper/ebin
#PROPER_PATH = ~/HiPE/proper/ebin

default: sudoku.beam

%.beam: %.erl
	erlc +debug_info -DPROPER -DTEST -pa $(PROPER_PATH) $<

test: sudoku.beam
	erl -noshell -eval "eunit:test(sudoku)." -s init stop

proper: sudoku.beam
	erl -noshell -pa $(PROPER_PATH) -eval "proper:module(sudoku, 2000)." -s init stop

clean:
	@$(RM) *.beam
