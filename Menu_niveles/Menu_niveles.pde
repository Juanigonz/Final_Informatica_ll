SubMenuLVL Niveles; // Instancia del objeto SubMenuLVL

void setup() {
  // Configuración inicial
  //fullScreen();
  size(1080, 720);
  frameRate(60);
  
  noCursor();
  
  // Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas
  Niveles = new SubMenuLVL(2, 3);
}

void draw() {
  // Color de fondo
  color bg = color(227, 247, 255);
  background(bg);
  
  // Color de los rectángulos
  color rectangulosC = color(150, 200, 255);
  color rectSeleccionado = color(255, 180, 120);
  
  // Dibuja la cuadrícula usando el método de la clase
  Niveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);
}

// Manejo de teclas
void keyPressed() {
  char teclaPresionada = key;
  
  switch(teclaPresionada){
    /*Paso una letra respecto a la tecla presionada*/
    case 'a':
      Niveles.moverSeleccion(teclaPresionada);
      break;
    case 's':
      Niveles.moverSeleccion(teclaPresionada);
      break;
    case 'd':
      Niveles.moverSeleccion(teclaPresionada);
    case 'w':
      Niveles.moverSeleccion(teclaPresionada);
    case 'k':
      Niveles.moverSeleccion(teclaPresionada);
    case 'l':
      Niveles.moverSeleccion(teclaPresionada);
    
      
  
  
  }
  
}
