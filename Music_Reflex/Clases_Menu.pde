class Menu{
    void menu_inicio(){
      mouseX = x;
      mouseY = y;
      background(gris);
      image(fondoMenu, 0, 0);
//Titulo
      fill(naranja);
      textSize(65);
      text(nombreJuego,450,100);
      
//Capitulos
      //Boton
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 260) && (mouseY < 310)){
          image(cartelSelec, 440, 230);
          
          fill(negro);
          textSize(40);
          text(selecCapitulos,510,300);
          if(keyPressed == true){
            if(keyCode == ENTER){
              delay(500);
              menu = 1;
              escena = 1;
            }
          }
         }else { 
          image(cartelNiveles, 450, 250);
      
          fill(negro);
          textSize(40);
          text(selecCapitulos,510,300);
         }
          
      }
      
//Puntuaciones
      //Boton
      fill(negro);
      textSize(40);
      text(selecPuntuacion,510,400);
      
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 360) && (mouseY < 410)){
          image(cartelSelec, 440, 330);
          
          fill(negro);
          textSize(40);
          text(selecPuntuacion,510,400);
          if(keyPressed == true){
            if(keyCode == ENTER){
              delay(500);
              menu = 1;
              escena = 2;
            }
          }
        }else { 
          image(cartelNiveles, 450, 350);
      
          fill(negro);
          textSize(40);
          text(selecPuntuacion,510,400);
        }
      }
      
//Salir
      //Boton  
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 460) && (mouseY < 510)){
          image(cartelSelec, 440, 430);
      
          fill(negro);
          textSize(40);
          text(selecSalir,510,500);
          if(keyPressed == true){
            if(keyCode == ENTER){
              salir = 1;
            }
          }
        }else { 
          image(cartelNiveles, 450, 450);
          
          fill(negro);
          textSize(40);
          text(selecSalir,510,500);
        }
      }
    }
  }
  
