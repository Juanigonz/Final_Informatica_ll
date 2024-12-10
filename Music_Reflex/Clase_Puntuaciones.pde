class Puntuaciones{
  String[] puntuaciones;

  int top_10(int escena) {
    
    textAlign(CORNER,CORNER);
    puntuaciones = loadStrings("Assets/text/puntajes_2.txt"); // Carga el archivo .txt
    ordenarPuntajes(puntuaciones);
    saveStrings("Assets/text/puntajes_2.txt", puntuaciones); // Guarda el archivo ordenado y recortado
    image(tablaPunt, 0, 0, width, height);       
    textSize(40); 
    fill(0);                   // Muestra el contenido del archivo en la pantalla 
          
    for (int i = 0; i < puntuaciones.length; i++) { 
      text(puntuaciones[i], 560, 165 + i * 50); 
    }
    escena = movimientoInicio.Volver(escena);
    return escena;
  }
}
void ordenarPuntajes(String[] puntuaciones){
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
