// Librerias
  import gifAnimation.*; // Agrega la posibilidad de utilizar gifs
  import processing.serial.*;

//String
  String[] puntuaciones;
  
  char teclaPresionada = '\0';
  
// Resoluciones
  int anchoOriginal = 1280;
  int altoOriginal = 720;  //Esta es la resolucion a la cual se diseño todo
  int anchoNuevo;
  int altoNuevo;    //Estas variables sirven para modificar las coordenadas x e y de las imagenes para que se coloquen correctamente segun la resolucion
  
// Colores definidos
  color gris = color(100, 100, 100);
  color negro = color(0, 0, 0);
  color blanco = color(255, 255, 255);

// Variables de posicion
  int x = 0;
  int y = 0;

/* escena = 1 Niveles
   escena = 2 Puntuaciones */
  int menu = 0;
  int escena = 0;
  int salir = 0; // Solo cambia si se presiona salir

// Clases
  Menu menuInicio = new Menu();
  Escena escenaInicio = new Escena();
  Movimiento movimientoInicio = new Movimiento();

// Gifs
  Gif myGif;
  Gif FondoNiv_1, FondoMenuNiv, FondoPunt;

// Imagenes
  PImage cartelNiveles, cartelSelecNiv, cartelPuntuaciones, cartelSelecPunt, cartelSalir, cartelSelecSalir;
  PImage cartelVolver, cartelTitulo, fondoMenu, cartelExit, cartelExitNo, cartelExitSi, selecExitNo, selecExitSi;
  PImage tablaPunt;

// Posiciones de las imagenes originales
  int[][] posiciones = {
    {450, 350},  //0-Cartel Niveles 
    {450, 350},  //1-Cartel Selec Niveles
    {450, 450},  //2-Cartel Puntuaciones 
    {450, 450},  //3-Cartel Selec Puntuaciones
    {450, 550},  //4-Cartel Salir 
    {450, 550},  //5-Cartel Selec Salir 
    {30, 625},   //6-Cartel Volver 
    {440, 0},    //7-Cartel Titulo 
    {0, 0},      //8-Fondo Menu 
    {470, 310},  //9-Cartel Exit 
    {635, 420},  //10-Cartel Exit No 
    {530, 420},  //11-Cartel Exit Si 
    {635, 420},  //12-Selec Exit No 
    {530, 420}   //13-Selec Exit Si 
  };
   int numImagenes = posiciones.length;
void setup() {
  //fullScreen();
  size(1280,720);
  anchoNuevo = width;
  altoNuevo = height;
  frameRate(60);
  smooth();
// Cargar todas las imágenes
  cargarImagenes(); 
// Carga el GIF animado
  cargarGifs();
  actualizarPosiciones();
}

void draw() {
  //println("Posicion X:", x, ", Posicion Y:", y, ", Menu", menu, ", Escena", escena, ", Salir", salir);
  if (menu == 0 && salir == 0) {
    menuInicio.menu_inicio();
    movimientoInicio.movimiento_menu();
  } else if (menu == 1 && escena == 1) {
    escenaInicio.escena_inicio();
  } else if (menu == 1 && escena == 2) {
    escenaInicio.escena_inicio();
  } else if (menu == 1 && salir == 1) {
    escenaInicio.Salir();
    movimientoInicio.movimiento_salir();
  }
}

// Función para cambiar la resolución de las coordenadas 
  int cambiarResolucion(int valor, int tamañoOriginal, int tamañoNuevo) {
    return (valor * tamañoNuevo) / tamañoOriginal; } 
// Función para actualizar las posiciones 
  void actualizarPosiciones() { 
    for (int i = 0; i < numImagenes; i++) { 
      int nuevoX = cambiarResolucion(posiciones[i][0], anchoOriginal, anchoNuevo);
      int nuevoY = cambiarResolucion(posiciones[i][1], altoOriginal, altoNuevo);
      posiciones[i][0] = nuevoX;
      posiciones[i][1] = nuevoY;
      println("Índice " + i + ": Nueva X = " + nuevoX + ", Nueva Y = " + nuevoY); 
    } 
  }
  
// Manejo de teclas
  void keyPressed() {
    teclaPresionada = key; // Almacena la última tecla presionada
  }
