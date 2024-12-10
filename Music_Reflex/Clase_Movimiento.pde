class Movimiento {
    int movimiento_menu(int y) {
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
            y = 590;
            delay(100);
        } else if (y > 590) {
            y = 390;
            delay(100);
        }
        return y;
    }

    int movimiento_salir(int x) {
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
            delay(100);
        } else if (x > 690) {
            x = 540;
            delay(100);
        }
        return x;
    }
    int Volver (int volver){ //coloca el boton volver en un lugar definido de la pantalla
       
      image(cartelVolver, posiciones[6][0], posiciones[6][1], width*0.19, height*0.062);
                
        if((teclaPresionada =='k') || (teclaPresionada == 'K')){
          delay(100);
          teclaPresionada = '\0';
          volver = 0;
          return volver;
        }else {
          return volver;
        }
    }
}
