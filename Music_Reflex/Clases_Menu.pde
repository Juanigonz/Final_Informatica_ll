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
      if((x > 450) && (x < 800)){
        if((y > 260) && (y < 310)){
          
          image(cartelSelecNiv, 440, 230);

          if(keyPressed == true){
            if(key == 'l'){
              
              menu = 1;
              escena = 1;
              delay(500);
            }
          }
         }else { 
          
           image(cartelNiveles, 450, 250);
         }        
      }
      
//Puntuaciones
      //Boton      
      if((x > 450) && (x < 800)){
        if((y > 360) && (y < 410)){
              
          image(cartelSelecPunt, 440, 330);
          
          if(keyPressed == true){
            if(key == 'l'){
              
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
      if((x > 450) && (x < 800)){
        if((y > 460) && (y < 510)){
          
          image(cartelSelecSalir, 440, 430);
      
          if(keyPressed == true){
            if(key == 'l'){
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
  
