class Puntuaciones {
  String[] puntuaciones;

  int top_10(int escena) {
    textAlign(CORNER, CORNER); // Alinea el texto en las esquinas
    puntuaciones = loadStrings("Assets/text/puntajes.txt"); // Carga el archivo .txt con las puntuaciones
    puntuaciones = ordenarPuntajes(puntuaciones); // Ordena las puntuaciones y obtiene el array actualizado
    saveStrings("Assets/text/puntajes.txt", puntuaciones); // Guarda el archivo ordenado y recortado
    image(tablaPunt, 0, 0, width, height); // Muestra la imagen de la tabla de puntuaciones en la pantalla
    textSize(40); // Establece el tamaño del texto
    fill(0); // Establece el color del texto a negro
    
    // Muestra el contenido del archivo en la pantalla
    for (int i = 0; i < puntuaciones.length; i++) {
      text(puntuaciones[i], 560, 165 + i * 50);
    }
    
    escena = movimientoInicio.Volver(escena); // Cambia la escena según la interacción del usuario
    return escena; // Devuelve el estado de la escena
  }

  // Clase auxiliar para almacenar las líneas y sus números correspondientes
  class LineaNumber {
    String line;
    int number;

    LineaNumber(String line, int number) {
      this.line = line;
      this.number = number;
    }
  }

  String[] ordenarPuntajes(String[] puntuaciones) {
    // Crea un array de objetos que contienen las líneas y los números
    LineaNumber[] lineaNumbers = new LineaNumber[puntuaciones.length];
    
    for (int i = 0; i < puntuaciones.length; i++) {
      String[] parts = split(puntuaciones[i], ' ');
      if (parts.length > 1) { // Verifica que haya al menos dos partes en la línea
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

    // Convierte los objetos de vuelta a líneas de texto 
    puntuaciones = new String[lineaNumbers.length]; 
    for (int i = 0; i < lineaNumbers.length; i++) {
      puntuaciones[i] = lineaNumbers[i].line; 
    }

    return puntuaciones; // Devuelve el array de puntuaciones ordenado
  }
}


  
