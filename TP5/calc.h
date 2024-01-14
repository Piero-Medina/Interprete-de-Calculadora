struct symrec {
  char *nombre;  // guardo una cadena 
  int tipo;      // tipo 1-VAR 2-CTE 3-FUNCION 
  union {
     double nro;     
     double (*func)(double);  // puntero a funcion que recibe 1 parametro tipo double y devuelve un double
  }valor;
};

struct init {   // estructura para agregar funciones al inicializar el programa
   char *nombre;
   int tipo;
   double (*funcion)(double);
};

int existe (char*);
int existePosicion (char*);
void agregar (char*, int, double);
void declarar (char*, int, double);
double identificador (char*);
double funcion(char*,double); 
double asignar (char*, int, double);

void aux (char*,int);
int tipoDeVariable(char*);
int esFuncion(char*);
int esVariable (char*);
void iniciarTabla(void);


