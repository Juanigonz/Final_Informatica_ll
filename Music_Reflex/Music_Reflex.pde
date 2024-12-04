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

//Control de escenas
/* escena = 1 Niveles
   escena = 2 Puntuaciones */
  int menu = 0;
  int escena = 0;
  int salir = 0; // Solo cambia si se presiona salir

// Clases
  Menu menuInicio = new Menu();
  Escena escenaInicio = new Escena();
  Movimiento movimientoInicio = new Movimiento();
  SubMenuLVL MenuNiveles; // Instancia del objeto SubMenuLVL
  Niveles Nivel_1,Nivel_2;        // Instancia del objetos Niveles

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
  
  PImage Nivel_1_i,Nivel_2_i, Nivel_2_i_bloqueado , Nivel_3_i , Nivel_3_i_bloqueado, Coming_Soon;
  Nivel_1_i=loadImage("Assets/img/Menu_Niveles/Nivel_1.jpg");
  
  Nivel_2_i=loadImage("Assets/img/Menu_Niveles/Nivel_2.jpg");
  Nivel_2_i_bloqueado=loadImage("Assets/img/Menu_Niveles/Nivel_2_Bloq.jpg");
  
  Nivel_3_i=loadImage("Assets/img/Menu_Niveles/Nivel_3.jpg");
  Nivel_3_i_bloqueado=loadImage("Assets/img/Menu_Niveles/Nivel_3_Bloq.jpg");
  
  Coming_Soon=loadImage("Assets/img/Menu_Niveles/Coming_Soon.jpg");
  
  Nivel_1_i.resize(width, height);
  Nivel_2_i.resize(width, height);
  Nivel_2_i_bloqueado.resize(width, height);
  Nivel_3_i.resize(width, height);
  Nivel_3_i_bloqueado.resize(width, height);
  Coming_Soon.resize(width, height);
  
  
// Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas
  MenuNiveles = new SubMenuLVL(2, 3,Nivel_1_i,Nivel_2_i, Nivel_2_i_bloqueado,Nivel_3_i,Nivel_3_i_bloqueado,Coming_Soon);
  
//comunicación con arduino
  Serial myPort;// Declara el objeto Serial
  String portName = Serial.list()[0];//Inicializar en el puerto adecuado
  myPort = new Serial(this, portName, 9600);//Configuración del puerto
  
// Configurar el puerto serie para lecturas
  myPort.bufferUntil('\n');
  
// Fondo del nivel 1
  PImage fondo = loadImage("Assets/img/Nivel_1/Fondo.jpg");
  PImage fondo_2=loadImage("Assets/img/Nivel_2/Fondo.jpg");
  fondo.resize(width, height);
  fondo_2.resize(width, height);
  
  Nivel_1 = new Niveles(8, height, width, fondo, "Nivel_1/", this, 2, myPort);
  Nivel_2 = new Niveles(8, height, width, fondo_2,"Nivel_2/",this, 3, myPort);
}

void draw() {
  //println("Posicion X:", x, ", Posicion Y:", y, ", Menu", menu, ", Escena", escena, ", Salir", salir);
  if (menu == 0 && salir == 0) {
    menuInicio.menu_inicio();
    movimientoInicio.movimiento_menu();
  } else if (menu == 1 && (escena >= 1 && escena <= 7)) {   
    if (escena == 1) {
      background(gris);
      // Colores de los rectángulos
      color rectangulosC = color(150, 200, 255);
      color rectSeleccionado = color(255, 180, 120);
  
      //Dibuja la cuadrícula usando el método de la clase
      MenuNiveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);
      
      movimientoInicio.Volver ();
      // Procesa la tecla presionada
     if (teclaPresionada != '\0') {
        escena = MenuNiveles.moverSeleccion(teclaPresionada);
        teclaPresionada = '\0'; // Resetea la tecla después de procesarla
      }
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
    print(escena);
  
  } else if (menu == 1 && escena == 8) {
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
