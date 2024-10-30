// SubMenuLVL.pde

class SubMenuLVL {
  // Constructor de la clase
  SubMenuLVL() {
    // Inicialización si es necesario
 }

// Función para dibujar una cuadrícula de rectángulos 3x2 adaptable al tamaño de la pantalla
  void dibujarCuadricula(int cols, int rows, float margenPorcentaje, float espaciadoPorcentaje) {
  float margin = width * margenPorcentaje;      // Margen desde los bordes en porcentaje del ancho
  float spacingX = width * espaciadoPorcentaje; // Espacio entre rectángulos horizontalmente en porcentaje
  float spacingY = height * espaciadoPorcentaje; // Espacio entre rectángulos verticalmente en porcentaje
  
  float rectWidth = (width - 2 * margin - (cols - 1) * spacingX) / cols;   // Ancho de cada rectángulo
  float rectHeight = (height - 2 * margin - (rows - 1) * spacingY) / rows; // Alto de cada rectángulo
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = margin + i * (rectWidth + spacingX); // Posición X del rectángulo
      float y = margin + j * (rectHeight + spacingY); // Posición Y del rectángulo
      fill(150, 200, 255); // Color de relleno
      rect(x, y, rectWidth, rectHeight); // Dibuja el rectángulo
    }
  }
 }
}
