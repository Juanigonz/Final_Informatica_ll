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
       } else{
         x = 480;
         y = 290;
       }
     }
     void movimiento_salir(){
       mouseX = x;
       mouseY = y;
       if( x >= 520 && x <= 670){
         if(keyPressed == true){
           if(keyCode == RIGHT){
           x = x - 120;
           delay(100);
           }
         }
         if(keyPressed == true){
           if(keyCode == LEFT){
           x = x + 120;
           delay(100);
           }
         }
       } else if (x < 520){
         x = 640;
         y = 400;
       } else if (x > 670){
         x = 520;
         y = 400;
       }
     }
   }  
     void Volver (){ //coloca el boton volver en un lugar definido de la pantalla
       noStroke();
       fill(verde);
       rect(30,625,170,50);
       stroke(0);
        
       fill(negro);
       textSize(40);
       text(selecVolver,80,665);
        
       if(keyPressed == true){
          if(keyCode == SHIFT){
           delay(500);
           menu = 0;
           escena = 0;
         }
       }
     }
     
