# Criação de uma linguagem de Programação baseada em C

Instale as dependências necessárias

```bash
sudo apt-get update
sudo apt-get install flex
sudo apt-get install bison
```

Processe o analisador léxico

```bash
flex lex.l
```

Processe o analisador sintático

```bash
bison -d parser.y
```

Compile com o compilador C

```bash
gcc lex.yy.c parser.tab.c -o <NomeDoArquivo> -lfl
```

Inicie o programa executável

```bash
./<NomeDoArquivo>
```