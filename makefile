all: prepare launch
COMP=g++
FLEX=flex
BISON=bison
prepare:
	@echo "reset..."
	@rm -f lex lex.yy.c parser.tab.c parser.tab.h main.txt main.cpp a.out
	@echo "lexico..."
	@$(FLEX) lex.l
	@echo "sintaxe..."
	@$(BISON) -d parser.y --warnings=none
	@$(COMP) lex.yy.c parser.tab.c -o lex

launch:
	@./lex $(file) main.txt main.cpp
	@echo "executando..."
	@$(COMP) main.cpp
	@./a.out