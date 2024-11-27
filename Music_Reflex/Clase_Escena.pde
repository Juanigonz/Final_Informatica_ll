class Escena {

    void escena_inicio() {
        if (escena == 1) { // Niveles
            background(gris);
            movimientoInicio.Volver ();
        } else if (escena == 2) { // Puntuaciones
            background(negro);
            movimientoInicio.Volver ();
        }
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

              if (keyPressed == true) {
                if ((key == 'l') || (key == 'L')) {
                    exit();
                  }
                }
            } else if ((x > 640) && (x < 690)) {
               image(cartelExitSi, posiciones[11][0], posiciones[11][1], width*0.046, height*0.083);
               image(selecExitNo, posiciones[12][0], posiciones[12][1], width*0.046, height*0.083);

               if (keyPressed == true) {
                 if ((key == 'l') || (key == 'L')) {
                   menu = 0;
                   salir = 0;
                   delay(100);
                 }  
               } 
            }
        }
    }
}
