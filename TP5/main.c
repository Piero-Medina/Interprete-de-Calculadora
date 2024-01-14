
#include <stdio.h>
#include "parser.h"
#include "calc.h"

int main() {

        iniciarTabla(); // iniciamos metiendo los valores de funciones y ctes en el diccionario
        
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}
