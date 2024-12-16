class Menu {
  int x;
  int y;
  int inicio = 0; // Variable para verificar si es la primera vez que se inicia el menú

  // Método para el menú de inicio
  void menu_inicio() {
    // Inicializa la posición vertical del menú
    if (inicio == 0) {
      y = 390;
      inicio = 1;
    }

    // Mueve el menú verticalmente
    y = movimientoInicio.movimiento_menu(y);

    // Renderiza el fondo del menú
    image(fondoMenu, 0, 0, width, height);

    // Renderiza el título
    image(cartelTitulo, posiciones[7][0], posiciones[7][1], width * 0.335, height * 0.388);

    // Renderiza y controla el botón de niveles
    if (y > 360 && y < 410) {
      image(cartelSelecNiv, posiciones[1][0], posiciones[1][1], width * 0.339, height * 0.131);
      if (teclaPresionada == 'l' || teclaPresionada == 'L') {
        escena = 1;
        delay(500); // Pausa para evitar repetición de teclas
        teclaPresionada = '\0'; // Resetea la tecla presionada
      }
    } else {
      image(cartelNiveles, posiciones[0][0], posiciones[0][1], width * 0.339, height * 0.131);
    }

    // Renderiza y controla el botón de puntuaciones
    if (y > 460 && y < 510) {
      image(cartelSelecPunt, posiciones[3][0], posiciones[3][1], width * 0.339, height * 0.131);
      if (teclaPresionada == 'l' || teclaPresionada == 'L') {
        escena = 8;
        teclaPresionada = '\0'; // Resetea la tecla presionada
      }
    } else {
      image(cartelPuntuaciones, posiciones[2][0], posiciones[2][1], width * 0.339, height * 0.131);
    }

    // Renderiza y controla el botón de salir
    if (y > 560 && y < 610) {
      image(cartelSelecSalir, posiciones[5][0], posiciones[5][1], width * 0.339, height * 0.131);
      if (teclaPresionada == 'l' || teclaPresionada == 'L') {
        escena = 15;
        teclaPresionada = '\0'; // Resetea la tecla presionada
      }
    } else {
      image(cartelSalir, posiciones[4][0], posiciones[4][1], width * 0.339, height * 0.131);
    }
  }

  // Método para salir del juego
  void Salir() {
    // Renderiza un fondo gris con transparencia
    fill(gris, 10);
    rect(0, 0, width, height);

    // Renderiza el cartel de confirmación de salida
    image(cartelExit, posiciones[9][0], posiciones[9][1], width * 0.226, height * 0.256);

    // Controla el botón "No"
    if (x > 530 && x < 550) {
      image(cartelExitNo, posiciones[10][0], posiciones[10][1], width * 0.046, height * 0.083);
      image(selecExitSi, posiciones[13][0], posiciones[13][1], width * 0.046, height * 0.083);
      if (teclaPresionada == 'l' || teclaPresionada == 'L') {
        exit(); // Cierra el programa
      }
    } else if (x > 640 && x < 690) {
      // Controla el botón "Sí"
      image(cartelExitSi, posiciones[11][0], posiciones[11][1], width * 0.046, height * 0.083);
      image(selecExitNo, posiciones[12][0], posiciones[12][1], width * 0.046, height * 0.083);
      if (teclaPresionada == 'l' || teclaPresionada == 'L') {
        escena = 0; // Vuelve al menú principal
        x = 480;
        y = 390;
        delay(100); // Pausa para evitar repetición de teclas
        teclaPresionada = '\0'; // Resetea la tecla presionada
      }
    }

    // Mueve la selección en el menú de salida
    x = movimientoInicio.movimiento_salir(x);
  }
}
