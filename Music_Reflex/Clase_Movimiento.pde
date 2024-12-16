class Movimiento {
    // Método para el movimiento del menú principal
    int movimiento_menu(int y) {
        // Verifica si la posición y está en el rango permitido para el movimiento
        if (y >= 390 && y <= 590) {
            // Si se presiona la tecla 's' o 'S', mueve el menú hacia abajo
            if ((teclaPresionada == 's') || (teclaPresionada == 'S')) {
                y = y + 100;
                delay(100); // Pausa para evitar la repetición de teclas
                teclaPresionada = '\0'; // Resetea la tecla presionada
            }
            // Si se presiona la tecla 'w' o 'W', mueve el menú hacia arriba
            if ((teclaPresionada == 'w') || (teclaPresionada == 'W')) {
                y = y - 100;
                delay(100); // Pausa para evitar la repetición de teclas
                teclaPresionada = '\0'; // Resetea la tecla presionada
            }
        } else if (y < 390) {
            y = 590; // Si y es menor que 390, lo ajusta a 590
            delay(100); // Pausa para evitar la repetición de teclas
        } else if (y > 590) {
            y = 390; // Si y es mayor que 590, lo ajusta a 390
            delay(100); // Pausa para evitar la repetición de teclas
        }
        return y; // Devuelve la nueva posición y
    }

    // Método para el movimiento en el menú de salida
    int movimiento_salir(int x) {
        // Verifica si la posición x está en el rango permitido para el movimiento
        if (x >= 520 && x <= 690) {
            // Si se presiona la tecla 'd' o 'D', mueve la selección a la izquierda
            if ((teclaPresionada == 'd') || (teclaPresionada == 'D')) {
                x = x - 130;
                delay(100); // Pausa para evitar la repetición de teclas
                teclaPresionada = '\0'; // Resetea la tecla presionada
            }
            // Si se presiona la tecla 'a' o 'A', mueve la selección a la derecha
            if ((teclaPresionada == 'a') || (teclaPresionada == 'A')) {
                x = x + 130;
                delay(100); // Pausa para evitar la repetición de teclas
                teclaPresionada = '\0'; // Resetea la tecla presionada
            }
        } else if (x < 520) {
            x = 670; // Si x es menor que 520, lo ajusta a 670
            delay(100); // Pausa para evitar la repetición de teclas
        } else if (x > 690) {
            x = 540; // Si x es mayor que 690, lo ajusta a 540
            delay(100); // Pausa para evitar la repetición de teclas
        }
        return x; // Devuelve la nueva posición x
    }

    // Método para controlar el botón "Volver"
    int Volver(int volver) {
        // Dibuja el botón "Volver" en la posición especificada
        image(cartelVolver, posiciones[6][0], posiciones[6][1], width * 0.19, height * 0.062);
        
        // Si se presiona la tecla 'k' o 'K', cambia la escena a 0 (menú principal)
        if ((teclaPresionada == 'k') || (teclaPresionada == 'K')) {
            delay(100); // Pausa para evitar la repetición de teclas
            teclaPresionada = '\0'; // Resetea la tecla presionada
            volver = 0; // Cambia la escena
            return volver; // Devuelve la nueva escena
        } else {
            return volver; // Devuelve la escena sin cambios
        }
    }
}
