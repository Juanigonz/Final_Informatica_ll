import processing.serial.*;
// Declara el objeto Serial
Serial myPort;

SubMenuLVL MenuNiveles; // Instancia del objeto SubMenuLVL
Niveles Nivel_1;        // Instancia del objeto Niveles
int nivel = 0;
char teclaPresionada = '\0'; // Inicialmente sin tecla presionada
PImage fondo;

void setup() {
  size(1280, 720);
  frameRate(30);
  noCursor();
  
  // Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas
  MenuNiveles = new SubMenuLVL(2, 3);
  
  // Busca y abre el puerto serie
  String portName = Serial.list()[1]; // Ajusta esto según tu puerto
  print(Serial.list()[0]);
  print(Serial.list()[1]);
  myPort = new Serial(this, portName, 9600);
  
  // Configura el puerto serie para lecturas
  myPort.bufferUntil('\n');
  
  // Fondo del nivel 1
  fondo = loadImage("Assets/img/Nivel_1/Fondo.jpg");
  fondo.resize(width, height);
  
  Nivel_1 = new Niveles(8, height, width, fondo, "Nivel_1/", this, 1);
}

void draw() {
  // Color de fondo
  color bg = color(227, 247, 255);
  background(bg);

  if (nivel == 0) {
    // Colores de los rectángulos
    color rectangulosC = color(150, 200, 255);
    color rectSeleccionado = color(255, 180, 120);

    //Dibuja la cuadrícula usando el método de la clase
    MenuNiveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);

    // Procesa la tecla presionada
   if (teclaPresionada != '\0') {
      nivel = MenuNiveles.moverSeleccion(teclaPresionada);
      print(nivel);
      teclaPresionada = '\0'; // Resetea la tecla después de procesarla
    }
  }
  if (nivel == 1) {
    // Lógica del nivel 1
    nivel = Nivel_1.interfazNivel();
    if (teclaPresionada != '\0') {
      Nivel_1.tecla_v = teclaPresionada;
      teclaPresionada = '\0';
    }
  }
}

// Manejo de teclas
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
      teclaPresionada = 'a'; // Asigna 'a' a la variable teclaPresionada
      println("Tecla 'a' recibida"); // Imprime para verificar que se recibe correctamente
    }
  }
}
