class Menu {
    void menu_inicio() {
        //background(gris);
        image(fondoMenu, 0, 0, width, height);
        //image(myGif, 0, 0, width, height);
        
     // Título
        image(cartelTitulo, posiciones[7][0], posiciones[7][1], width*0.335, height*0.388);

     // Capítulos - Niveles
        // Botón
        if ((x > 450) && (x < 800)) {
            if ((y > 360) && (y < 410)) {
              
                 image(cartelSelecNiv, posiciones[1][0], posiciones[1][1], width*0.339, height*0.131);

                    if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                        menu = 1;
                        escena = 1;
                        delay(500);
                        teclaPresionada = '\0';
                    }
            } else {
                image(cartelNiveles, posiciones[0][0], posiciones[0][1], width*0.339, height*0.131);
            }
        }

      // Puntuaciones
        // Botón      
        if ((x > 450) && (x < 800)) {
            if ((y > 460) && (y < 510)) {
                image(cartelSelecPunt, posiciones[3][0],posiciones[3][1], width*0.339, height*0.131);

                    if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                        menu = 1;
                        escena = 3;
                        teclaPresionada = '\0';
                    }
            } else {
                image(cartelPuntuaciones, posiciones[2][0], posiciones[2][1], width*0.339, height*0.131);
            }
        }

      // Salir
        // Botón  
        if ((x > 450) && (x < 800)) {
            if ((y > 560) && (y < 610)) {
                image(cartelSelecSalir, posiciones[5][0], posiciones[5][1], width*0.339, height*0.131);

                    if ((teclaPresionada == 'l') || (teclaPresionada == 'L')) {
                        menu = 1;
                        salir = 1;
                        teclaPresionada = '\0';
                    }
            } else {
                image(cartelSalir, posiciones[4][0], posiciones[4][1], width*0.339, height*0.131);
            }
        }
    }
}
