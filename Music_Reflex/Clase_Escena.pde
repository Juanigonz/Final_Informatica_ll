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
        if((y > 400) && (y < 430)){
          if((x > 530) && (x < 550)){
            
            fill(naranja);
            rect(510, 395, 55, 45);
            fill(negro);
            textSize(40);
            text("SI",520,430);
           
            if(keyPressed == true){
              if(key == 'l'){
                exit();
              }
            }
          }
          else if((x > 640) && (x < 690)){
            
            fill(naranja);
            rect(635, 395, 60, 45);
            fill(negro);
            textSize(40);
            text("NO",640,430);
            
            if(keyPressed == true){
              if(key == 'l'){
                menu = 0;
                salir = 0;
                delay(100);
              }  
            } 
          }
        }
     }
  }
