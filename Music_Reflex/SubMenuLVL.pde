class SubMenuLVL {
  int filas; // Número de filas
  int columnas; // Número de columnas
  int seleccionFila; // Fila seleccionada
  int seleccionColumna; // Columna seleccionada

  // Constructor de la clase
  SubMenuLVL(int filas, int columnas) {
    this.filas = filas; //Notar el uso de this para referieme al atributo filas de la clase y no del objeto para evitar una ambigüedad (lo mismo para columnas)
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
        
        
        //Dibujo un rectangulo un poco más grande para entender en que rectangulo estoy parado
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
  int moverSeleccion(char tecla) {
    
    int opc=1;
    
    switch(tecla){
      case 'a':
        seleccionColumna = (seleccionColumna - 1 + columnas) % columnas; // el "%" es para evitar que se alga de los valores que van de 0 a columnas-1 y el + columna es para evitar valores negativos
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
      case 'l':
        opc=validar_nivel(seleccionFila,seleccionColumna);
        break;
      case 'k':
        opc=0;
        break;
    }
    return opc;
  }
  int validar_nivel(int fila_selec, int columna_selec) {
    String [] niveles_desbloqueados = loadStrings("Assets/text/niveles_desbloqueados.txt");
    
    int niveles_des = int(niveles_desbloqueados[0].trim());
    
    if(niveles_des>=2 && fila_selec==0 && columna_selec==0){
      return 2;
    }
    if(niveles_des>=3 && fila_selec==0 && columna_selec==1){
      return 3;
    }
    
    else{
      return 1;
    }
    
  }

}
