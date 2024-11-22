class Menu{
    void menu_inicio(){
      mouseX = x;
      mouseY = y;
      background(gris);
      image(fondoMenu, 0, 0);
      //image(myGif, 0, 0);
//Titulo
      fill(naranja);
      textSize(65);
      text(nombreJuego,450,100);
      
//Capitulos
      //Boton
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 260) && (mouseY < 310)){
          
          image(cartelSelecNiv, 440, 230);

          if(keyPressed == true){
            if(keyCode == ENTER){
              
              delay(500);
              menu = 1;
              escena = 1;
            }
          }
         }else { 
          
           image(cartelNiveles, 450, 250);
         }        
      }
      
//Puntuaciones
      //Boton      
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 360) && (mouseY < 410)){
          
          image(cartelSelecPunt, 440, 330);
          
          if(keyPressed == true){
            if(keyCode == ENTER){
              
              delay(500);
              menu = 1;
              escena = 2;
            }
          }
        }else { 
          
          image(cartelPuntuaciones, 450, 350);
    
        }
      }
      
//Salir
      //Boton  
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 460) && (mouseY < 510)){
          
          image(cartelSelecSalir, 440, 430);
      
          if(keyPressed == true){
            if(keyCode == ENTER){
              menu = 1;
              salir = 1;
            }
          }
        }else { 
          
          image(cartelSalir, 450, 450);

        }
      }
    }
  }
  
