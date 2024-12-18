// Importa la librería para comunicación serial
import processing.serial.*;

// Variable para almacenar la última tecla presionada
char teclaPresionada = '\0';

// Resoluciones originales y nuevas
int anchoOriginal = 1280;
int altoOriginal = 720;  // Esta es la resolución original para la que se diseñó el juego
int anchoNuevo;
int altoNuevo;    // Variables para ajustar las coordenadas según la nueva resolución

// Colores predefinidos
color gris = color(100, 100, 100);
color negro = color(0, 0, 0);
color blanco = color(255, 255, 255);

// Clases del juego
Menu menuInicio = new Menu();
Movimiento movimientoInicio = new Movimiento();
Puntuaciones puntuacionesInicio = new Puntuaciones();
Menu_LVL MenuNiveles; // Instancia del objeto SubMenuLVL
Niveles Nivel_1, Nivel_2; // Instancia de los objetos Niveles

// Posiciones originales de las imágenes en la pantalla
int[][] posiciones = {
  {450, 350},  // 0 - Cartel Niveles 
  {450, 350},  // 1 - Cartel Selección Niveles
  {450, 450},  // 2 - Cartel Puntuaciones 
  {450, 450},  // 3 - Cartel Selección Puntuaciones
  {450, 550},  // 4 - Cartel Salir 
  {450, 550},  // 5 - Cartel Selección Salir 
  {30, 625},   // 6 - Cartel Volver 
  {440, 0},    // 7 - Cartel Título 
  {0, 0},      // 8 - Fondo del Menú 
  {470, 310},  // 9 - Cartel Exit 
  {635, 420},  // 10 - Cartel Exit No 
  {530, 420},  // 11 - Cartel Exit Sí 
  {635, 420},  // 12 - Selección Exit No 
  {530, 420}   // 13 - Selección Exit Sí 
};
int numImagenes = posiciones.length;

void setup() {
  // Configura el tamaño de la ventana
  //fullScreen();
  size(1280, 720);
  anchoNuevo = width;
  altoNuevo = height;
  frameRate(60); // Establece la tasa de fotogramas
  smooth(); // Suaviza los bordes
  cargarSetup(); // Llama a una función para cargar la configuración inicial
  actualizarPosiciones(); // Ajusta las posiciones de las imágenes según la resolución
}

int escena = 0;

void draw() {
  if (escena == 0) {
    menuInicio.menu_inicio(); // Muestra el menú de inicio
  } else if (escena >= 1 && escena <= 7) {   
    if (escena == 1) {
      background(gris); // Fondo gris
      // Colores de los rectángulos
      color rectangulosC = color(150, 200, 255);
      color rectSeleccionado = color(255, 180, 120);

      // Dibuja la cuadrícula usando el método de la clase
      escena = MenuNiveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);
    }
    if (escena == 2) {
      // Lógica del nivel 1
      escena = Nivel_1.interfazNivel();
      if (teclaPresionada != '\0') {
        Nivel_1.tecla_v = teclaPresionada; // Almacena la última tecla presionada en el nivel 1
        teclaPresionada = '\0'; // Resetea la variable
      }
    }
    if (escena == 3) {
      // Lógica del nivel 2
      escena = Nivel_2.interfazNivel();
      if (teclaPresionada != '\0') {
        Nivel_2.tecla_v = teclaPresionada; // Almacena la última tecla presionada en el nivel 2
        teclaPresionada = '\0'; // Resetea la variable
      }
    }
  } else if (escena == 8) {
    escena = puntuacionesInicio.top_10(escena); // Muestra las puntuaciones
  } else if (escena == 15) {
    menuInicio.Salir(); // Llama al método para salir del menú
  }
}

// Manejo de teclas presionadas
void keyPressed() {
  teclaPresionada = key; // Almacena la última tecla presionada
}

void serialEvent(Serial myPort) {
  // Lee el estado desde el puerto serie
  String estado = myPort.readStringUntil('\n');
  
  if (estado != null) {
    estado = trim(estado); // Elimina los espacios en blanco
    
    // Verifica si el estado recibido es la letra 'a'
    if (estado.equals("a")) {
      teclaPresionada = 'a';
    }
    if (estado.equals("s")) {
      teclaPresionada = 's';
    }
    if (estado.equals("d")) {
      teclaPresionada = 'd'; 
    }
    if (estado.equals("w")) {
      teclaPresionada = 'w'; 
    }
    if (estado.equals("l")) {
      teclaPresionada = 'l';
    }
    if (estado.equals("k")) {
      teclaPresionada = 'k'; 
    }
  }
}
