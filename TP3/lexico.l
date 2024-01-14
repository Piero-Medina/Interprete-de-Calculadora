%{
   #include <stdio.h>
   #include "tokens.h"
%}
%option noinput
%option nounput
%option outfile="scanner.c" 
%option header-file="scanner.h" 

letra          [a-zA-Z]
digito         [0-9]  
expo           [eE][+-]?{digito}+
fracc          {digito}*\.{digito}+|{digito}+\.{digito}*
letra_Digito   [a-zA-Z0-9]
opera_Asig     [+\-*/][=]
entero         {digito}+
real           {fracc}+{expo}?|{digito}+{expo}
numeros        {entero}|{real}
otros          [[:punct:]]{-}[+\-*/=^()]
espacios       [[:space:]]{-}[\n]

%%
var|cte|salir                                               return PALABRARESERVADA;
{letra}{letra_Digito}*                                      return IDENTIFICADOR;                                                           
{numeros}                                                   return NRO;  
{opera_Asig}                                                return ASIGNACION;
"+"                                                         return '+';
"-"                                                         return '-';
"*"                                                         return '*';
"/"                                                         return '/';
"^"                                                         return '^';
"="                                                         return '=';
"("                                                         return '(';
")"                                                         return ')';
"\n"                                                        return NUEVA_LINEA;

{letra}{letra_Digito}*{otros}+({letra_Digito}|{otros})*     printf("Error lexico: identificador invalido: %s\n",yytext);
{entero}+{letra}+{letra_Digito}*                            printf("Error lexico: constante invalida: %s\n",yytext);
{real}+{letra}+{real}*                                      printf("Error lexico: Real invalida: %s\n",yytext);
{otros}+                                                    printf("Error lexico: cadena desconocida: %s\n",yytext);
{espacios}                                                  ;
%%



