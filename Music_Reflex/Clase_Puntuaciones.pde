class Puntuaciones{
  String[] puntuaciones;
  int i=0;
  int top_10(int escena) {
    textAlign(CORNER,CORNER);
    puntuaciones = loadStrings("Assets/text/puntajes.txt"); // Carga el archivo .txt
    if(puntuaciones!=null){
      puntuaciones=ordenarPuntajes(puntuaciones);
    }
    else{
       puntuaciones = new String[] { "\0" };
    }
    
    saveStrings("Assets/text/puntajes.txt", puntuaciones); // Guarda el archivo ordenado y recortado
    image(tablaPunt, 0, 0, width, height);       
    textSize(40); 
    fill(0);                   // Muestra el contenido del archivo en la pantalla 
          
    for (int i = 0; (i < puntuaciones.length) && (i<10) ; i++) { 
      text(puntuaciones[i], 560, 165 + i * 50); 
    }
    escena = movimientoInicio.Volver(escena);
    return escena;
  }
}
String [] ordenarPuntajes(String[] puntuaciones){
    // Crea un array de objetos que contengan las líneas y los números
    LineaNumber[] lineaNumbers = new LineaNumber[puntuaciones.length];
    
    for (int i = 0; i < puntuaciones.length; i++) {
      String[] parts = split(puntuaciones[i], ' ');
      //print(parts[1]);
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
    
    for (int i = 0; i < puntuaciones.length; i++) {
      puntuaciones[i] = lineaNumbers[i].line;
    }
    return puntuaciones;
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
