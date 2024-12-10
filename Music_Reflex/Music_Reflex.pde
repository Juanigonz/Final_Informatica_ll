// Librerias
  import processing.serial.*;

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

// Clases
  Menu menuInicio = new Menu();
  Movimiento movimientoInicio = new Movimiento();
  Puntuaciones puntuacionesInicio = new Puntuaciones();
  Menu_LVL MenuNiveles; // Instancia del objeto SubMenuLVL
  Niveles Nivel_1,Nivel_2;        // Instancia del objetos Niveles

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
  cargarSetup();
  actualizarPosiciones();
}
  int escena = 0;
void draw() {

  if (escena == 0) {
    menuInicio.menu_inicio();
  } else if (escena >= 1 && escena <= 7) {   
    if (escena == 1) {
      background(gris);
      // Colores de los rectángulos
      color rectangulosC = color(150, 200, 255);
      color rectSeleccionado = color(255, 180, 120);
  
      //Dibuja la cuadrícula usando el método de la clase
      escena = MenuNiveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);
      

    }
    if (escena == 2) {
      // Lógica del nivel 1
      escena = Nivel_1.interfazNivel();
      if (teclaPresionada != '\0') {
        Nivel_1.tecla_v = teclaPresionada;
        teclaPresionada = '\0';
      }
    }
    if(escena==3){
      
      escena = Nivel_2.interfazNivel();
      
      if (teclaPresionada != '\0') {
        Nivel_2.tecla_v = teclaPresionada;
        teclaPresionada = '\0';
      }
    }
  
  } else if (escena == 8) {
    escena = puntuacionesInicio.top_10(escena);
  } else if (escena == 15) {
    menuInicio.Salir();
    //movimientoInicio.movimiento_salir();
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
