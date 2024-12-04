class Escena {
    void escena_inicio() {
          textAlign(CORNER,CORNER);
          puntuaciones = loadStrings("Assets/text/puntajes_2.txt"); // Carga el archivo .txt
          ordenarPuntajes();
          saveStrings("Assets/text/puntajes_2.txt", puntuaciones); // Guarda el archivo ordenado y recortado
          
          image(FondoNiv_1, 0, 0, width, height);
          image(tablaPunt, 0, 0, width, height);       
          textSize(40); 
          fill(0);                   // Muestra el contenido del archivo en la pantalla 
          
          for (int i = 0; i < puntuaciones.length; i++) { 
            text(puntuaciones[i], 560, 165 + i * 50); }
            movimientoInicio.Volver ();
    }

    void Salir() {
        // Diseño
        fill(gris, 10); // Color gris con transparencia
        rect(0, 0, width, height); // Dibujar un rectángulo translúcido
        
        image(cartelExit, posiciones[9][0], posiciones[9][1], width*0.226, height*0.256);

        if ((y > 400) && (y < 430)) {
            if ((x > 530) && (x < 550)) {
              image(cartelExitNo, posiciones[10][0], posiciones[10][1], width*0.046, height*0.083);
              image(selecExitSi, posiciones[13][0], posiciones[13][1], width*0.046, height*0.083);

                if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                    exit();
                  }
                  
            } else if ((x > 640) && (x < 690)) {
               image(cartelExitSi, posiciones[11][0], posiciones[11][1], width*0.046, height*0.083);
               image(selecExitNo, posiciones[12][0], posiciones[12][1], width*0.046, height*0.083);

                 if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                   menu = 0;
                   salir = 0;
                   x = 480;
                   y = 390;
                   delay(100);
                   teclaPresionada = '\0';
                 }  
            }
        }
    }
}
  void ordenarPuntajes(){
        // Crea un array de objetos que contengan las líneas y los números
    LineaNumber[] lineaNumbers = new LineaNumber[puntuaciones.length];
    for (int i = 0; i < puntuaciones.length; i++) {
      String[] parts = split(puntuaciones[i], ' ');
      if (parts.length > 1) { // Verifica que haya al menos dos partes
        int number = int(parts[1]); // Asume que el número está después de un espacio
        lineaNumbers[i] = new LineaNumber(puntuaciones[i], number);
      } else {
        lineaNumbers[i] = new LineaNumber(puntuaciones[i], 0); // Asigna 0 si no hay número
      }
    }
    
    // Ordena los objetos por el número en orden descendente
    for (int i = 0; i < lineaNumbers.length - 1; i++) {
      for (int j = i + 1; j < lineaNumbers.length; j++) {
        if (lineaNumbers[i].number < lineaNumbers[j].number) {
          LineaNumber temp = lineaNumbers[i];
          lineaNumbers[i] = lineaNumbers[j];
          lineaNumbers[j] = temp;
        }
      }
    }
    
    // Recorta el array a un máximo de diez líneas
    int newSize = min(10, lineaNumbers.length);
    LineaNumber[] trimmedLineaNumbers = new LineaNumber[newSize];
    arrayCopy(lineaNumbers, trimmedLineaNumbers, newSize);
    
    // Convierte los objetos de vuelta a líneas de texto
    puntuaciones = new String[newSize];
    for (int i = 0; i < newSize; i++) {
      puntuaciones[i] = trimmedLineaNumbers[i].line;
    }
  }
// Clase auxiliar para almacenar las líneas y sus números
class LineaNumber {
  String line;
  int number;

  LineaNumber(String line, int number) {
    this.line = line;
    this.number = number;
  }
}
