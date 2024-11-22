class Niveles{
  
  //Constructor de niveles
  
  Niveles(float velocidad,float Al, float An,PImage Fondo){
    
    //Uso this para referirme a las variables globales de la clase
    
    this.Al=Al;
    this.An=An;
    this.velocidad=velocidad;
    
    margenV = An * 0.01; //margen vertical usado también para los cuadros del centro y el hud
  
    //Parametros del rectángulo del hud
    alto_hud = Al * 0.1;
    ancho_hud = An * 0.3;
    x_hud = An - ancho_hud - margenV;
    y_hud = margenV;
    
    //Parametros de las imagenes
    cuadros = new ArrayList<Cuadro>();
    cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    espacioEntreCuadros = alto_hud*2;
    this.Fondo=Fondo;
    
    cuadroCentralTamaño=alto_hud;
    
    //Variables referidas al nivel
    puntaje=0;
    
  }
  //Imagenes
  PImage Cuadrado_error=loadImage("Assets/img/Cuadrado_error.png");
  PImage Cuadrado_correcto=loadImage("Assets/img/Cuadrado_correcto.png");
  
  PImage Fondo;
  PImage cinta_transportadora=loadImage("Assets/img/Cinta_transportadora.png");
  
  PImage caja_abierta_Ab=loadImage("Assets/img/Caja_abierta_Ab.png");
  PImage caja_abierta_Ar=loadImage("Assets/img/Caja_abierta_Ar.png");
  PImage caja_abierta_De=loadImage("Assets/img/Caja_abierta_De.png");
  PImage caja_abierta_Iz=loadImage("Assets/img/Caja_abierta_Iz.png");
  
  
  PImage caja_abierta=loadImage("Assets/img/Caja_abierta.png");
  PImage caja_cerrada=loadImage("Assets/img/Caja_cerrada.png");
  
  //Variable donde se guarda el alto y el ancho
  float Al;
  float An;
  
  //Variables globales del HUD
  float alto_hud;
  float ancho_hud;
  float x_hud;
  float y_hud;
  
  //Variables de los cuadros que se mueven horizontalmente (las imagenes de las cajas)
  ArrayList<Cuadro> cuadros; //Una lista de objetos
  float velocidad;
  float espacioEntreCuadros;
  
  //Margen vertical
  float margenV;
  
  // Variables para el cuadro en el centro
  float cuadroCentralAlpha = 0; // Opacidad del cuadro central
  float cuadroCentralTamaño; // Tamaño del cuadro central
  PImage Imagen_de_salida; //Variable para cuadar la imagen de la felcha que salio
  boolean mostrarCuadroCentral = false; // Controla si se muestra el cuadro central
  
  //Variable por si el juagador aprieta bien o mal
  char tecla_v;
  int B_o_M;
  int Opacidad_B_o_M;
  float puntaje;
  
  //Metodo que maneja la parte gráfica de los niveles
  
  void interfazNivel() {
    
    int i, j;
    image(fondo,0,0);
    // HUD de las flechas presentadas
    fill(200);
    textSize((height*0.1));
    text(""+puntaje,(width/2)-(width/5)/2,height*0.1);
   
   image(cinta_transportadora,x_hud,y_hud,ancho_hud,alto_hud);
    
   clip(x_hud, y_hud, ancho_hud, alto_hud);

    for ( i = cuadros.size() - 1; i >= 0; i--) {
        Cuadro cuadro = cuadros.get(i);
        cuadro.mover(velocidad);
        cuadro.dibujar(height*0.1,height*0.12 );

        // Eliminar cuadro si sale de la pantalla
        if (cuadro.x + alto_hud < x_hud) {
          //Guardo la imagen asociada a la caja con la flecha que va a ser eliminada
          Imagen_de_salida=cuadros.get(i).imagen;
          mostrarCuadroCentral = true; // Mostrar cuadro central
          cuadroCentralAlpha = 255;   // Restaurar opacidad
          cuadros.remove(i);

        }
    }

    // Agregar un nuevo cuadro (caja) si hay espacio suficiente al final
    if (cuadros.isEmpty() || cuadros.get(cuadros.size() - 1).x < x_hud + ancho_hud - alto_hud - espacioEntreCuadros) {
        cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    }
    noClip();

    // Dibuja los cuadros (cajas) alrededor del círculo
    float lado_fle = (Al / 5) * 0.9;
    float margen_fleL = ((An / 5) - lado_fle) / 2;
    float margen_fleV = ((Al / 5) - lado_fle) / 2;
    
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            float x_fle = margen_fleL + (lado_fle + (margen_fleL * 2)) * i;
            float y_fle = margen_fleV + (Al / 5) * j;

            if ((i == 2 && j == 1) || (i == 1 && j == 2) || (i == 3 && j == 2)||(i == 2 && j == 3)){
              image(caja_cerrada,x_fle,y_fle,lado_fle,lado_fle);
              
            }
        }
    }
  

    // Dibujar el cuadro central si está activado
    if (mostrarCuadroCentral) {
        
        float x_disp = An * 0.5;
        float y_disp = Al * 0.5;
        
        imageMode(CENTER);
        tint(255,cuadroCentralAlpha);
        image(Imagen_de_salida,x_disp,y_disp,height*0.12,height*0.1 );
        
        // Reducir la opacidad
        cuadroCentralAlpha -= (2.5*velocidad);

        // Desactivar el cuadro central cuando desaparezca
        if (cuadroCentralAlpha <= 0) {
            mostrarCuadroCentral = false;
            Opacidad_B_o_M=255;
            B_o_M=2;
            puntaje-=300;
        }
        
    }
    noTint();
    imageMode(CORNER);
    
    //Manejo de botones y mensajes de error o acierto en el nivel
    tint(255,Opacidad_B_o_M);
    switch(tecla_v){
      case 'a':
        if((caja_abierta_Iz==Imagen_de_salida) && (mostrarCuadroCentral==true)){
          mostrarCuadroCentral=false;
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=1;
          puntaje+=2.5*cuadroCentralAlpha;
          print(puntaje);
        }
        else if ((caja_abierta_Iz!=Imagen_de_salida) || (mostrarCuadroCentral==false)){
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=2;
          puntaje-=300;
        }
        break;
        
        case 's':
        if((caja_abierta_Ab==Imagen_de_salida) && (mostrarCuadroCentral==true)){
          mostrarCuadroCentral=false;
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=1;
          puntaje+=2.5*cuadroCentralAlpha;
        }
        else if ((caja_abierta_Ab!=Imagen_de_salida) || (mostrarCuadroCentral==false)){
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=2;
          puntaje-=300;
        }
        break;
        case 'd':
        if((caja_abierta_De==Imagen_de_salida) && (mostrarCuadroCentral==true)){
          mostrarCuadroCentral=false;
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=1;
          puntaje+=2.5*cuadroCentralAlpha;
        }
        else if ((caja_abierta_De!=Imagen_de_salida) || (mostrarCuadroCentral==false)){
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=2;
          puntaje-=300;
        }
        break;
        case 'w':
        if((caja_abierta_Ar==Imagen_de_salida) && (mostrarCuadroCentral==true)){
          mostrarCuadroCentral=false;
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=1;
          puntaje+=2.5*cuadroCentralAlpha;
        }
        else if ((caja_abierta_Ar!=Imagen_de_salida) || (mostrarCuadroCentral==false)){
          Opacidad_B_o_M=255;
          tecla_v = 'f';
          B_o_M=2;
          puntaje-=300;
        }
        break;

    }
    
    if (B_o_M == 1) { // Cuadro correcto
      image(Cuadrado_correcto, 0, 0, width * 0.1, width * 0.1);
      
      Opacidad_B_o_M -= 5; // Reducir gradualmente la opacidad
      if (Opacidad_B_o_M <= 0) {
          B_o_M = 0; // Restablecer el estado solo si la opacidad es 0
      }
      
    } 
    else if (B_o_M == 2 ) { // Cuadro de error
    
      image(Cuadrado_error, 0, 0, width * 0.1, width * 0.1);
      
      Opacidad_B_o_M -= 5; // Reducir gradualmente la opacidad
      if (Opacidad_B_o_M <= 0) {
          B_o_M = 0; // Restablecer el estado solo si la opacidad es 0
      }
      
    }

    noTint();

    /*
    //Lineas que utilice para determinar la proporciones de la pantalla
    for (i = 1; i < 5; i++) {
        line(An / 5 * i, 0, An / 5 * i, Al);
        line(0, Al / 5 * i, An, Al / 5 * i);
    }*/
  }
  
  PImage obtenerImagenAleatoria() {
    float random = random(4);
    
    if(random >= 0.0 && random <= 1.0){
      return caja_abierta_Ab;
    }
    else if(random >1.0 && random <=2.0){
      return caja_abierta_Ar;
    } 
    else if(random >2.0 && random <=3.0){
      return caja_abierta_De;
    } 
    else if(random >3.0 && random <=4.0){
      return caja_abierta_Iz;
    }
    return caja_cerrada;
  }
  
}

class Cuadro{
  
  float x, y; // Posición del cuadro
  PImage imagen; // Imagen asociada al cuadro
  
  Cuadro(float x, float y,PImage imagen) {
    this.x = x;
    this.y = y;
    
    this.imagen = imagen;
  }
  
  void mover(float velocidad) {
    x -= velocidad; // Mover hacia la izquierda
  }
  
  void dibujar(float alto, float ancho) {
    image(imagen, x, y, ancho, alto); // Dibujar imagen escalada al tamaño del cuadro
  }
  
}
