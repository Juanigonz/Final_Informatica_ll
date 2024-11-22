class Movimiento{
     void movimiento_menu(){
       if( y >= 290 && y <= 490){
         if(keyPressed == true){
           if(key == 's'){
           y = y + 100;
           delay(100);
           }
         }
         if(keyPressed == true){
           if(key == 'w'){
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
       if( x >= 520 && x <= 690){
         if(keyPressed == true){
           if(key == 'd'){
           x = x - 130;
           delay(100);
           }
         }
         if(keyPressed == true){
           if(key == 'a'){
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
          if(key =='k'){
           delay(500);
           menu = 0;
           escena = 0;
         }
       }
     }
     
