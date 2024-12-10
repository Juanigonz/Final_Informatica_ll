class Menu {
  int x;
  int y;
  int inicio = 0;
    void menu_inicio() {
      if (inicio == 0){
        y = 390;
        inicio = 1;
      }
      y = movimientoInicio.movimiento_menu(y);
      //background(gris);
      image(fondoMenu, 0, 0, width, height);
      
   // Título
      image(cartelTitulo, posiciones[7][0], posiciones[7][1], width*0.335, height*0.388);
  
   // Capítulos - Niveles
      // Botón
          if ((y > 360) && (y < 410)) {
            
               image(cartelSelecNiv, posiciones[1][0], posiciones[1][1], width*0.339, height*0.131);
  
                  if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                      escena = 1;
                      delay(500);
                      teclaPresionada = '\0';
                  }
          } else {
              image(cartelNiveles, posiciones[0][0], posiciones[0][1], width*0.339, height*0.131);
          }
  
    // Puntuaciones
      // Botón      
          if ((y > 460) && (y < 510)) {
              image(cartelSelecPunt, posiciones[3][0],posiciones[3][1], width*0.339, height*0.131);
  
                  if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                      escena = 8;
                      teclaPresionada = '\0';
                  }
          } else {
              image(cartelPuntuaciones, posiciones[2][0], posiciones[2][1], width*0.339, height*0.131);
          }
  
    // Salir
      // Botón  
          if ((y > 560) && (y < 610)) {
              image(cartelSelecSalir, posiciones[5][0], posiciones[5][1], width*0.339, height*0.131);
  
                  if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                      escena = 15;
                      teclaPresionada = '\0';
                  }
          } else {
              image(cartelSalir, posiciones[4][0], posiciones[4][1], width*0.339, height*0.131);
          }
    }
    void Salir() {
        
        // Diseño
        fill(gris, 10); // Color gris con transparencia
        rect(0, 0, width, height); // Dibujar un rectángulo translúcido
        
        image(cartelExit, posiciones[9][0], posiciones[9][1], width*0.226, height*0.256);

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
                   escena = 0;
                   x = 480;
                   y = 390;
                   delay(100);
                   teclaPresionada = '\0';
                 }  
            }
            x = movimientoInicio.movimiento_salir(x);
    }
} 
