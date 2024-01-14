#include "scanner.h"
#include "tokens.h"

char *token_names[] = {"Fin de archivo","asignacion","palabraReservada","identificador","nro","nueva linea"};

int main(){
 enum token t;
   while((t = yylex())!= FDT){
        if(t <= PALABRARESERVADA){
         printf("Token: %s\n",yytext);
        }
        else if(t == IDENTIFICADOR || t == NRO){
         printf("Token: %s\t lexema: %s\n",token_names[t],yytext);
        }
        else if(t == NUEVA_LINEA){
         printf("Token: 'NL'\n");
        }
        else{
         printf("Token: \'%c\'\n",yytext[0]);
           }
        }
        printf("Token: %s\n",token_names[t]);
       
       return 0;        
   }
