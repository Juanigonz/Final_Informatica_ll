class Menu_LVL {
  int filas; // Número de filas
  int columnas; // Número de columnas
  int seleccionFila; // Fila seleccionada
  int seleccionColumna; // Columna seleccionada
  int escena;
  
  PImage Nivel_1, Nivel_2 , Nivel_2_bloqueado , Nivel_3 , Nivel_3_bloqueado, Coming_Soon;

  // Constructor de la clase
  Menu_LVL(int filas, int columnas,PImage Nivel_1,PImage Nivel_2,PImage Nivel_2_bloqueado,PImage Nivel_3,PImage Nivel_3_bloqueado,PImage Coming_Soon) {
    this.filas = filas; //Notar el uso de this para referieme al atributo filas de la clase y no del objeto para evitar una ambigüedad (lo mismo para columnas)
    this.columnas = columnas;
    seleccionFila = 0; // Selección inicial en la primera fila
    seleccionColumna = 0; // Selección inicial en la primera columna
    
    this.Nivel_1=Nivel_1;
    
    this.Nivel_2=Nivel_2;
    this.Nivel_2_bloqueado=Nivel_2_bloqueado;
    
    this.Nivel_3=Nivel_3;
    this.Nivel_3_bloqueado=Nivel_3_bloqueado;
    
    this.Coming_Soon=Coming_Soon;
    
    
  }
  /*
  EXPLICACIÓN DEL MÉTODO "dibujarCuadricula":
    este método se encarga de calcular las proporciones y de dibujar todo lo referido al menu de los niveles
    con las imagenes del nivel que se manejan con la función dibujar_imagenes y la función moverSeleccion.
  */
  // Función para dibujar la cuadrícula
  int dibujarCuadricula(float margenLPorcentaje, float margenVPorcentaje, color colorNormal, color colorSeleccionado) {
    
    float An = width; // Ancho de la pantalla
    float Al = height; // Alto de la pantalla

    float margenL = An * margenLPorcentaje; // Margen lateral
    float margenV = Al * margenVPorcentaje; // Margen vertical

    float espacioDL = An - (margenL * 2); // Espacio disponible lateral
    float espacioDV = Al - (margenV * 2); // Espacio disponible vertical

    float espacioEnRL = (espacioDL / columnas) * 0.05; // Espaciado horizontal
    float espacioEnRV = (espacioDV / filas) * 0.05;    // Espaciado vertical

    float ancho = (espacioDL / columnas)- (espacioEnRL * 2);
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
        //rect(x,y,ancho,alto);
        dibujar_imagenes(x,y,ancho,alto,i,j);
      }
    }
     // Procesa la tecla presionada
        escena = moverSeleccion(teclaPresionada);
        teclaPresionada = '\0'; // Resetea la tecla después de procesarla
        return escena;
  }
  
  /*
  EXPLICACIÓN DEL MÉTODO "dibujar_imagenes":
    este método determina quie imagen se dibuja dependiendo del int del archivo niveles_desbloqueados
    y de la posición de j e i en el bucle 
  */
  void dibujar_imagenes(float x,float y,float ancho, float alto,int i,int j){
    
    String [] niveles_desbloqueados = loadStrings("Assets/text/niveles_desbloqueados.txt");
    int niveles_des = int(niveles_desbloqueados[0].trim());
    
    if(i==0 && j==0){
      image(Nivel_1,x,y,ancho,alto);
    }
    if(i==0 && j==1){
      if(niveles_des>=3){
        image(Nivel_2,x,y,ancho,alto);
      }
      else{
        image(Nivel_2_bloqueado,x,y,ancho,alto);
      }
    }
    if(i==0 && j==2){
      if(niveles_des>=4){
        image(Nivel_3,x,y,ancho,alto);
      }
      else{
        image(Nivel_3_bloqueado,x,y,ancho,alto);
      }
    }
    if(i==1){
      image(Coming_Soon,x,y,ancho,alto);
    }
    
    
  }
  /*
  EXPLICACIÓN DEL MÉTODO "moverSeleccion":
    Este método modifica los valores de seleccionColumnas y seleccionFila para devolverles 
    un valor que determina en que iteración de bucle dobele se dibuja el rectangulo naranja
    que sirve para que el suario sepa en donde está parado, esto para las letras a, s, d y w
    para la letras l llama al método validar_nivel para determinar si en la posición en la que
    está el cuadro naranja es una opción válida para jugar o no.
  */
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
    }
    opc=movimientoInicio.Volver(opc);
    return opc;
  }
  /*
  EXPLICACIÓN DEL MÉTODO "validar_nivel":
    Este método lo que hace es determinar según el archivo de texto niveles_desbloqueados
    si la posición en la que se encuentra el recrtángulo naranja es válida para jugar, esto
    lo determina a través de una variable de control a la que le retornamos el valor que es el 
    que recibe opc en moverSeleccion y que es el que retorna para devolverselo al atributo
    escena.
  */
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
