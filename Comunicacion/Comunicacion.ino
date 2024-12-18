void setup() {
  
  //Pin del led para ver la comunicación bidireccional
  pinMode(13, OUTPUT); 

  //Pines de botones 
  pinMode(9, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  pinMode(6, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  Serial.begin(9600);         // Inicializa la comunicación serie
}

void loop() {
  String inVal="\0";

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
  //Detectá si hay datos disponibles para leer en el puerto serie
  if(Serial.available() > 0){
    inVal = Serial.readStringUntil('\n');//Lee los dátos del puerto hasta econtrar un salto de líneas
  }
  
  /*Si el dato es la letra G entonces encidende y apaga 2 veces la luz del arduino*/
  if(inVal=="G"){
    for(int i=0;i<2;i++){  
      digitalWrite(13,HIGH);
      delay(500);
      digitalWrite(13,LOW);
      delay(500);
    }

  }

}



