class Movimiento{
     void movimiento_menu(){
       if( y >= 290 && y <= 490){
         if(keyPressed == true){
           if(keyCode == DOWN){
           y = y + 100;
           delay(100);
           }
         }
         if(keyPressed == true){
           if(keyCode == UP){
           y = y - 100;
           delay(100);
           }
         }
       } else if (y < 290){
         x = 480;
         y = 490;
         delay(100);
       } else if (y > 490){
         x = 480;
         y = 290;
         delay(100);
       } 
     }
     void movimiento_salir(){
       mouseX = x;
       mouseY = y;
       if( x >= 520 && x <= 690){
         if(keyPressed == true){
           if(keyCode == RIGHT){
           x = x - 130;
           delay(100);
           }
         }
         if(keyPressed == true){
           if(keyCode == LEFT){
           x = x + 130;
           delay(100);
           }
         }
       } else if (x < 520){
         x = 670;
         y = 415;
         delay(100);
       } else if (x > 690){
         x = 540;
         y = 415;
         delay(100);
       }
     }
   }  
     void Volver (){ //coloca el boton volver en un lugar definido de la pantalla
       
       image(cartelVolver, 30, 625);
       
       if(keyPressed == true){
          if(keyCode == SHIFT){
           delay(500);
           menu = 0;
           escena = 0;
         }
       }
     }
     
