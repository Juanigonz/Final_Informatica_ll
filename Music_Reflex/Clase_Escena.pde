class Escena{
    void escena_inicio(){
       if(escena == 1){      //Niveles
        background(gris);
        Volver();
       }
       else if(escena == 2){ //Puntuaciones
         background(negro);
        Volver();
      }
    }
    void Salir (){
      //Diseño
       fill(gris, 10); // Color azul con transparencia
       rect(0, 0, 1280, 720); // Dibujar un rectángulo translúcido
       
       fill (azul);
       rect(460, 310, 300, 150);
       
       
       fill(negro);
       textSize(40);
       text("¿Estas Seguro?",485,360);
       
       fill(negro);
       textSize(40);
       text("SI",520,430);
       
       fill(negro);
       textSize(40);
       text("NO",640,430);
      
      //Funcionalidad
        if((mouseX > 520) && (mouseX < 550)){
          if((mouseY > 400) && (mouseY < 430)){
            fill(naranja);
            rect(510, 395, 55, 45);
            if(keyPressed == true){
              if(keyCode == ENTER){
                exit();
              }
            }
          } 
        }else if((mouseX > 640) && (mouseX < 690)){
          if((mouseY > 400) && (mouseY < 430)){
            fill(naranja);
            rect(635, 395, 60, 45);
            if(keyPressed == true){
              if(keyCode == ENTER){
                salir = 0;
                delay(100);
              }
            }
          } 
        }
     }
  }
