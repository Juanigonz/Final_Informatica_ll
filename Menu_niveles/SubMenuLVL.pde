class SubMenuLVL {
  int filas; // Número de filas
  int columnas; // Número de columnas
  int seleccionFila; // Fila seleccionada
  int seleccionColumna; // Columna seleccionada

  // Constructor de la clase
  SubMenuLVL(int filas, int columnas) {
    this.filas = filas;
    this.columnas = columnas;
    seleccionFila = 0; // Selección inicial en la primera fila
    seleccionColumna = 0; // Selección inicial en la primera columna
  }

  // Función para dibujar la cuadrícula
  void dibujarCuadricula(float margenLPorcentaje, float margenVPorcentaje, color colorNormal, color colorSeleccionado) {
    float An = width; // Ancho de la pantalla
    float Al = height; // Alto de la pantalla

    float margenL = An * margenLPorcentaje; // Margen lateral
    float margenV = Al * margenVPorcentaje; // Margen vertical

    float espacioDL = An - (margenL * 2); // Espacio disponible lateral
    float espacioDV = Al - (margenV * 2); // Espacio disponible vertical

    float espacioEnRL = (espacioDL / columnas) * 0.05; // Espaciado horizontal
    float espacioEnRV = (espacioDV / filas) * 0.05;    // Espaciado vertical

    float ancho = (espacioDL / columnas) - (espacioEnRL * 2);
    float alto = (espacioDV / filas) - (espacioEnRV * 2);

    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        float x = (margenL + espacioEnRL) + (ancho + (espacioEnRL * 2)) * j;
        float y = (margenV + espacioEnRV) + (alto + (espacioEnRV * 2)) * i;

        // Cambiar el color si es el rectángulo seleccionado
        if (i == seleccionFila && j == seleccionColumna) {
          fill(colorSeleccionado);
          rect(x-espacioEnRL,y-espacioEnRV,ancho+(2*espacioEnRL),alto+(2*espacioEnRV));
        }
        fill(colorNormal);
        rect(x, y, ancho, alto);
      }
    }
  }

  // Mover la selección con las flechas
  void moverSeleccion(char direccion) {
    
    switch(direccion){
      case 'a':
        seleccionColumna = (seleccionColumna - 1 + columnas) % columnas;
        break;
      case 'd':
        seleccionColumna = (seleccionColumna + 1) % columnas;
        break;
      case 's':
        seleccionFila = (seleccionFila - 1 + filas) % filas;
        break;
      case 'w':
        seleccionFila = (seleccionFila + 1) % filas;
        break;

    }
  }
}
