%code top{
	#include <stdio.h>
	#include "scanner.h"
}

%code provides {
	void yyerror(const char *);
	extern int nerrlex;
}

%define api.value.type{char *}

%defines "parser.h"					
%output "parser.c"

%start sesionDeCalculadora
%define parse.error verbose  

%token 	FDT VAR CTE SALIR IDENTIFICADOR NRO 
%token MASIGUAL "+="
%token MENOSIGUAL "-="
%token PRODUCTOIGUAL "*="
%token DIFERENCIAIGUAL "/="

%right "+=" "-=" "*=" "/=" '='
%left '-' '+'
%left '*' '/'
%right '^'
%precedence NEG

%%     
sesionDeCalculadora :              %empty                               
                               |   sesionDeCalculadora linea 
                               ;
  
linea :                            expresion '\n'                       {printf("expresion\n");}
                               |   declaracion '\n'
                               |   error '\n'
                               |   SALIR '\n'                           {if (yynerrs || nerrlex) YYABORT; else YYACCEPT;}
                               |   '\n'                          
                               ; 

expresion :                        IDENTIFICADOR '=' expresion          {printf("asignacion\n");}
                               |   IDENTIFICADOR "+=" expresion         {printf("asignacion con suma\n");}
                               |   IDENTIFICADOR "-=" expresion         {printf("asignacion con resta\n");}
                               |   IDENTIFICADOR "*=" expresion         {printf("asignacion con multiplicacion\n");}
                               |   IDENTIFICADOR "/=" expresion         {printf("asignacion con division\n");}                   
                               |   expresion '+' expresion              {printf("suma\n");}                  
                               |   expresion '-' expresion              {printf("resta\n");}
                               |   expresion '*' expresion              {printf("multiplicacion\n");}
                               |   expresion '/' expresion              {printf("division\n");}
                               |   '-' expresion %prec NEG              {printf("cambio signo\n");}
                               |   expresion '^' expresion              {printf("potenciacion\n");}                    
                               |   '('expresion')'                      {printf("Cierra parentesis\n");}
                               |   IDENTIFICADOR'('expresion')'         {printf("funcion\n");}
                               |   IDENTIFICADOR                        {printf("ID\n");}
                               |   NRO                                  {printf("numero\n");}    
                               ;
                                 
declaracion :                      VAR IDENTIFICADOR                    {printf("define ID como variable\n");}
                               |   VAR IDENTIFICADOR '=' expresion      {printf("define ID como variable con valor inicial\n");}
                               |   CTE IDENTIFICADOR '=' expresion      {printf("define ID como constante\n");}
                               ;
%%

int nerrlex = 0;

void yyerror(const char *s){
	puts(s);
	return;
}
