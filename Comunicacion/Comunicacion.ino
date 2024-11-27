void setup() {
  pinMode(7, INPUT_PULLUP);   // Configura el pin 7 con resistencia pull-up interna
  Serial.begin(9600);         // Inicializa la comunicación serie
}

void loop() {
  if (digitalRead(7) == LOW) {   // Detecta si el botón está presionado (pin LOW)
    Serial.println("a");          // Imprime 'A' cuando se presiona el botón
    delay(200);                   // Retraso para evitar rebotes
  }
}



