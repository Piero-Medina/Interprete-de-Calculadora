#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h> 
#include "calc.h"
#include "parser.h"
#define MAX 200

// estructura llena, para iniciar la calculadora con funciones
struct init inicial [8] = 
{
   {"sin",3,sin},
   {"cos",3,cos},
   {"tan",3,tan},
   {"asin",3,asin},
   {"acos",3,acos},
   {"atan",3,atan},
   {"sqrt",3,sqrt},
   {"log",3,log},
};

struct symrec diccionario[MAX];
int posicionDiccionario = 0;
char msgError[100];

//
int existe (char *nombreVariable){
  for (int i = 0; i < posicionDiccionario; i++){
      if (strcmp(diccionario[i].nombre,nombreVariable) == 0){
          return 1;
      }           
  }
  return 0; 
}

//
int existePosicion (char* nombreVariable){
   for (int i = 0; i < posicionDiccionario; i++){
      if (strcmp(diccionario[i].nombre,nombreVariable) == 0){
          return i;
      }      
   } 
}

//
void agregar (char *nombreVariable, int tipoVariable, double valorVariable){ // solo agregamos CTE y VAR   
  if (posicionDiccionario < MAX){
      diccionario[posicionDiccionario].nombre = nombreVariable;
      diccionario[posicionDiccionario].tipo = tipoVariable;
      diccionario[posicionDiccionario].valor.nro = valorVariable;

      posicionDiccionario++;
  } 
}

//
void declarar (char *nombreVariable, int tipoVariable, double valorVariable){ // solo declararemos variables tipo VAR o CTE
   if (existe(nombreVariable) == 1){
      sprintf(msgError,"Error, identificador ya declarado como variable");
      yyerror(msgError);
   }
   else if (existe(nombreVariable) == 0){
      agregar(nombreVariable,tipoVariable,valorVariable);
      printf("%s: %.10g \n", nombreVariable, valorVariable);  
   }
}

//
double identificador (char *nombreVariable){
   int posicionBuscada = 0;

   if(existe(nombreVariable) == 1){
      posicionBuscada = existePosicion(nombreVariable);
      return diccionario[posicionBuscada].valor.nro;
   }
}

//
double funcion(char* cadena, double valor){ 
    int posicion;    
    posicion = existePosicion(cadena);
    return diccionario[posicion].valor.func(valor);    
}

//0-normal,1-sumaIgual,2-restaIgual,3-productoIgual,4-divisionIgual
double asignar (char* cadena,int operador,double nuevoValor){  
   int posicion;                                               
   posicion = existePosicion(cadena);

   switch (operador)
   {
   case 0:
      diccionario[posicion].valor.nro = nuevoValor;
      break;
   case 1:
      diccionario[posicion].valor.nro += nuevoValor;
      break;
   case 2:   
      diccionario[posicion].valor.nro -= nuevoValor;
      break;
   case 3:
      diccionario[posicion].valor.nro *= nuevoValor;
      break;
   case 4:
      diccionario[posicion].valor.nro /= nuevoValor;
      break; 
   }
   return diccionario[posicion].valor.nro;
}

//
void aux (char *nombreVariable,int problema){
    switch(problema)
    {
    case 1:
        sprintf(msgError,"Error : ID %s no declarado",nombreVariable);
        yyerror(msgError);
        break;
    case 2:
        sprintf(msgError,"Error, ID %s no es una funcion",nombreVariable);
        yyerror(msgError);
        break;
    case 3:
        sprintf(msgError,"Los operadores de asignación solo admiten una variable como operando izquierdo");
        yyerror(msgError);
        break;
    }      
}

//
int tipoDeVariable(char *cadena){
    int posicion;
    posicion = existePosicion(cadena);
    return diccionario[posicion].tipo;
}

//
int esFuncion(char* cadena){  
   if(existe(cadena) && tipoDeVariable(cadena) == 3){
      return 1;
   }
   else {
      return 0;
   }
}

//
int esVariable (char* cadena){
    if(existe(cadena) && tipoDeVariable(cadena) == 1){
      return 1;
   }
   else {
      return 0;
   }
}

//
void iniciarTabla (void){
   for (int i = 0; i < 8; i++){
      diccionario[i].nombre = inicial[i].nombre;
      diccionario[i].tipo = inicial[i].tipo;
      diccionario[i].valor.func = inicial[i].funcion;
      posicionDiccionario++;
   }
   agregar("pi", 2, 3.141592654);
   agregar("e", 2, 2.718281828);
}

