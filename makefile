all: prepare launch
CPPC=gcc
FLEX=flex
BISON=bison
prepare:
	@echo "reset..."
	@rm -f lex lex.yy.c parser.tab.c parser.tab.h main.txt main.cpp a.out
	@echo "lexico..."
	@$(FLEX) lex.l
	@echo "sintaxe..."
	@$(BISON) -d parser.y --warnings=none
	@$(CPPC) lex.yy.c parser.tab.c -o lex

launch:
	@echo "Detectando programa: $(file)..."
	@./lex $(file) main.txt main.cpp
	@echo "Programa DETECTADO! Tá na hora de rodar..."
	@$(CPPC) main.cpp
	@./a.out