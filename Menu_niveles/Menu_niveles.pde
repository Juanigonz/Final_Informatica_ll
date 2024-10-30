SubMenuLVL pruebaDeBiblio;

void setup() {
  //fullScreen();
  size(1080,720);
  frameRate(60);  
}

void draw() {
   background(227, 247, 255); // Vuelve a pintar el fondo en cada fotograma

  // Llama a la función de la biblioteca para dibujar la cuadrícula de rectángulos
  pruebaDeBiblio.dibujarCuadricula(1, 1, 0.1, 0.05);
  
}
