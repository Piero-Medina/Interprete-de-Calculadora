%code top{
	#include <stdio.h>
	#include <math.h>    
	#include "scanner.h"
	#include "calc.h"	
}

%code provides {
	void yyerror(const char *);
	extern int nerrlex;
}

%union {
   double num;
   char *pala1;
}
                                                                
%defines "parser.h"					
%output "parser.c"

%start sesionDeCalculadora
%define parse.error verbose  

%token<num> NRO                                 
%token<pala1> IDENTIFICADOR VAR CTE SALIR
%type<num> expresion

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
  
linea :                            expresion '\n'                       {printf("%.10g\n",$1);}
                               |   declaracion '\n'
                               |   error '\n'
                               |   SALIR '\n'                           {if (yynerrs || nerrlex) YYABORT; else YYACCEPT;}
                               |   '\n'                          
                               ;

expresion :                        IDENTIFICADOR '=' expresion          {if(esVariable($1)){$$ = asignar($1,0,$3);} else{aux($1,3);YYERROR;}} 
                               |   IDENTIFICADOR "+=" expresion         {if(esVariable($1)){$$ = asignar($1,1,$3);} else{aux($1,3);YYERROR;}}
                               |   IDENTIFICADOR "-=" expresion         {if(esVariable($1)){$$ = asignar($1,2,$3);} else{aux($1,3);YYERROR;}}
                               |   IDENTIFICADOR "*=" expresion         {if(esVariable($1)){$$ = asignar($1,3,$3);} else{aux($1,3);YYERROR;}}
                               |   IDENTIFICADOR "/=" expresion         {if(esVariable($1)){$$ = asignar($1,4,$3);} else{aux($1,3);YYERROR;}}                   
                               |   expresion '+' expresion              {$$ = $1 + $3;}                  
                               |   expresion '-' expresion              {$$ = $1 - $3;}
                               |   expresion '*' expresion              {$$ = $1 * $3;}
                               |   expresion '/' expresion              {$$ = $1 / $3;}
                               |   '-' expresion %prec NEG              {$$ = -$2;}
                               |   expresion '^' expresion              {$$ = pow($1,$3);}                    
                               |   '('expresion')'                      {$$ = $2;}
                               |   IDENTIFICADOR'('expresion')'         {if(esFuncion($1)){$$ = funcion($1,$3);} else{aux($1,2);YYERROR;}}
                               |   IDENTIFICADOR                        {if(existe($1)){$$ = identificador($1);} else{aux($1,1);YYERROR;}}     
                               |   NRO 
                               ;
                                 
declaracion :                      VAR IDENTIFICADOR                    {declarar($2,1,0);}
                               |   VAR IDENTIFICADOR '=' expresion      {declarar($2,1,$4);}
                               |   CTE IDENTIFICADOR '=' expresion      {declarar($2,2,$4);}
                               ;
%%

int nerrlex = 0;

void yyerror(const char *s){
	puts(s);
	return;
}

