// Piero Joesph Medina Angulo
#include<stdio.h>
#include<ctype.h>

int main (){
    
    char caracter;
    caracter = getchar();

    while(caracter != EOF){

        if (islower(caracter)){ // pregunta si el caracter es minuscula
           caracter = toupper(caracter); // covierte el caracter en mayuscula
           putchar(caracter);                             
        }
        else if (isupper(caracter)){ // pregunta si el caracter es mayuscula
            caracter = tolower(caracter); // convierte el caracter en miniscula
            putchar(caracter);
        }
        else if (isdigit(caracter)){ // pregunta si es un digito
            //no hacemos nada
        }
        else {  
            putchar(caracter); 
        }   
         
        caracter = getchar();
    }
    printf("\n"); // un salto de linea
      
    return 0;
}