//Variables globales
  String nombreJuego="Music Reflex";
  String selecCapitulos="Niveles";
  String selecPuntuacion="Puntajes";
  String selecSalir="Salir";
  String selecVolver="Volver";
  
  color naranja= color(240,165,0);
  color azul= color(0,0,255);
  color rojo= color(255,0,0);
  color verde= color(0,255,0);
  color amarrillo= color(255,255,0);
  color gris= color(100,100,100);
  color negro= color(0,0,0);
  color blanco= color(255,255,255);
  
/*escena = 1 Niveles
  escena = 2 Puntuaciones*/
  int menu = 0;
  int escena = 0;
    
  Menu menuInicio = new Menu();
  Escena escenaInicio = new Escena();

 
  
void setup(){
  size(1280,720,P2D);
  frameRate(30);
  smooth();
  background(gris);
}

void draw(){
  println("Posicion X:",mouseX, ", Posicion Y:", mouseY, ", Menu", menu, ", Escena", escena);
  if (menu == 0){
    menuInicio.menu_inicio();
  }
  else if ((menu == 1) && (escena == 1)){
     escenaInicio.escena_inicio(); 
  }
  else if ((menu == 1) && (escena == 2)){
     escenaInicio.escena_inicio();
  }
}

 class Menu{
    void menu_inicio(){
      background(gris);
      
//Titulo
      fill(naranja);
      textSize(65);
      text(nombreJuego,450,100);
      
//Capitulos
      //Boton
      noStroke();
      fill(verde);
      rect(450,165,350,50);
      stroke(0);
      
      fill(negro);
      textSize(40);
      text(selecCapitulos,510,200);
      
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 160) && (mouseY < 210)){
          if(mousePressed == true){
            delay(500);
            menu = 1;
            escena = 1;
          }
        }
      }
      
//Puntuaciones
      //Boton
      noStroke();
      fill(verde);
      rect(450,265,350,50);
      stroke(0);
      
      fill(negro);
      textSize(40);
      text(selecPuntuacion,510,300);
      
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 260) && (mouseY < 310)){
          if(mousePressed == true){
            delay(500);
            menu = 1;
            escena = 2;
          }
        }
      }
      
//Salir
      //Boton
      noStroke();
      fill(verde);
      rect(450,365,350,50);
      stroke(0);
      
      fill(negro);
      textSize(40);
      text(selecSalir,510,400);
      
      if((mouseX > 450) && (mouseX < 800)){
        if((mouseY > 360) && (mouseY < 410)){
          if(mousePressed == true){
            exit();
          }
        }
      }
    }
  }
  
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
  }
 
 void Volver(){ //coloca el boton volver en un lugar definido de la pantalla
   noStroke();
        fill(verde);
        rect(30,625,170,50);
        stroke(0);
        
        fill(negro);
        textSize(40);
        text(selecVolver,80,665);
        
        if((mouseX > 30) && (mouseX < 200)){
        if((mouseY > 625) && (mouseY < 673)){
          if(mousePressed == true){
            delay(500);
            menu = 0;
            escena = 0;
          }
        }
      }
 }
