//Librerias
  import gifAnimation.*; // Agrega la posibilidad de utilizar gifs

//Variables globales
  String nombreJuego="Music Reflex";
  String selecCapitulos="Niveles";
  String selecPuntuacion="Puntajes";
  String selecSalir="Salir";
  String selecVolver="Volver";
  
//colores definidos
  color naranja= color(240,165,0);
  color azul= color(0,0,255);
  color rojo= color(255,0,0);
  color verde= color(0,255,0);
  color amarrillo= color(255,255,0);
  color gris= color(100,100,100);
  color negro= color(0,0,0);
  color blanco= color(255,255,255);
  
//Cursor
  int x = 0;
  int y = 0;

/*escena = 1 Niveles
  escena = 2 Puntuaciones*/
  int menu = 0;
  int escena = 0;
  int salir = 0; //solo sirve cambia si se preciona salir

//Clases
  Menu menuInicio = new Menu();
  Escena escenaInicio = new Escena();
  Movimiento movimientoInicio = new Movimiento();

//Gifs
  Gif myGif;

//Imagenes
  PImage cartelNiveles, cartelSelecNiv, cartelPuntuaciones, cartelSelecPunt, cartelSalir, cartelSelecSalir, cartelVolver, fondoMenu;
  
void setup(){
  size(1280,720);
  frameRate(30);
  smooth();
  background(gris);
  
// Carga el GIF animado 
  myGif = new Gif(this, "Assets/Gif/prueba.gif"); 
  myGif.loop(); // Hace que el GIF se reproduzca en bucle

//Carga las imagenes
  cartelNiveles = loadImage("Assets/img/Cartel Niveles.png");
  cartelSelecNiv = loadImage("Assets/img/Cartel Selec Niveles.png");
  cartelPuntuaciones = loadImage("Assets/img/Cartel Puntuaciones.png");
  cartelSelecPunt = loadImage("Assets/img/Cartel Selec Puntuaciones.png");
  cartelSalir = loadImage("Assets/img/Cartel Salir.png");
  cartelSelecSalir = loadImage("Assets/img/Cartel Selec Salir.png");
  cartelVolver = loadImage("Assets/img/Cartel Volver.png");
  fondoMenu = loadImage("Assets/img/Fondo menu.png");
}

void draw(){
  println("Posicion X:", x, ", Posicion Y:", y, ", Menu", menu, ", Escena", escena, ", Salir", salir);
  if (menu == 0 && salir == 0){
    menuInicio.menu_inicio();
    movimientoInicio.movimiento_menu();
  }
  else if ((menu == 1) && (escena == 1)){
     escenaInicio.escena_inicio(); 
  }
  else if ((menu == 1) && (escena == 2)){
     escenaInicio.escena_inicio();
  }
  else if ((menu == 1) && (salir == 1)){
     escenaInicio.Salir();
     movimientoInicio.movimiento_salir();
  }
}
 
   
     
