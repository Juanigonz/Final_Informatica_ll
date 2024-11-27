void setup() {
  pinMode(9, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  pinMode(8, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  pinMode(7, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  pinMode(6, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  pinMode(5, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  pinMode(4, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  Serial.begin(9600);         // Inicializa la comunicación serie
}

void loop() {
  if (digitalRead(5) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("a");          // Imprime 'A' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
  if (digitalRead(6) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("w");          // Imprime 'W' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
  if (digitalRead(4) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("s");          // Imprime 'S' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
  if (digitalRead(7) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("d");          // Imprime 'D' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
  if (digitalRead(8) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("l");          // Imprime 'L' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
  if (digitalRead(9) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("k");          // Imprime 'K' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
}



