class Movimiento {
    void movimiento_menu() {
        if (y >= 390 && y <= 590) {
                if ((teclaPresionada == 's') || (teclaPresionada == 'S')) {
                    y = y + 100;
                    delay(100);
                    teclaPresionada = '\0';
                }
                if ((teclaPresionada == 'w') || (teclaPresionada == 'W')) {
                    y = y - 100;
                    delay(100);
                    teclaPresionada = '\0';
                }
            
        } else if (y < 390) {
            x = 480;
            y = 590;
            delay(100);
        } else if (y > 590) {
            x = 480;
            y = 390;
            delay(100);
        }
    }

    void movimiento_salir() {
        if (x >= 520 && x <= 690) {
                if ((teclaPresionada == 'd') || (teclaPresionada == 'D')) {
                    x = x - 130;
                    delay(100);
                    teclaPresionada = '\0';
                }
                if ((teclaPresionada == 'a') || (teclaPresionada == 'A')) {
                    x = x + 130;
                    delay(100);
                    teclaPresionada = '\0';
                }
            
        } else if (x < 520) {
            x = 670;
            y = 415;
            delay(100);
        } else if (x > 690) {
            x = 540;
            y = 415;
            delay(100);
        }
    }
    void Volver (){ //coloca el boton volver en un lugar definido de la pantalla
       
      image(cartelVolver, posiciones[6][0], posiciones[6][1], width*0.19, height*0.062);
                
        if((teclaPresionada =='k') || (teclaPresionada == 'K')){
          delay(500);
          menu = 0;
          escena = 0;
          teclaPresionada = '\0';
        }
    }
}
