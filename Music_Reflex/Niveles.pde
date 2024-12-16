//Manejo de audio
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Manejo de comunicación
import processing.serial.*;


class Niveles{
  
  //Constructor de niveles
  Niveles(float velocidad,float Al, float An,PImage Fondo, String Nivel,PApplet parent,int nivel,Serial myPort){
    
    //Inicialización del puerto
    this.myPort=myPort;
    
    // Inicializar Minim
    minim = new Minim(parent);
    
    //Uso this para referirme a las variables globales de la clase
    
    this.Al=Al;
    this.An=An;
    this.velocidad=velocidad*(An/1280);
    
    margenV = An * 0.01; //margen vertical usado también para los cuadros del centro y el hud
  
    //Parametros del rectángulo del hud
    alto_hud = Al * 0.1;
    ancho_hud = An * 0.3;
    x_hud = An - ancho_hud - margenV;
    y_hud = margenV;
    
    //Parametros de las imagenes
    puntaje=0;
    
    //Variable referidas a la música del nivel
    player = minim.loadFile("Assets/music/"+Nivel+"Musica.mp3",1024);
    this.nivel=nivel;
    
    //Imagenes del juego cargar
    this.Nivel=Nivel;
    directorio = "Assets/img/"+this.Nivel;
    this.Fondo=Fondo;
    
    cargar_images_nivel();
    
    cuadros = new ArrayList<Cuadro>();
    cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    espacioEntreCuadros = alto_hud*2;
    
  }
  //Musica del juego
  Minim minim;
  AudioPlayer player;
  int nivel;

  //Imagenes
  private String Nivel="Nivel_" + (nivel+1) + "/";
  private String directorio = "Assets/img/"+Nivel;
  
  private PImage Cuadrado_error;
  private PImage Cuadrado_correcto;
  private PImage Fondo;
  private PImage cinta_transportadora;
  private PImage flecha_abajo, flecha_arriba, flecha_derecha, flecha_izquierda;
  private PImage flecha_abajo_press, flecha_arriba_press, flecha_derecha_press, flecha_izquierda_press;
  private PImage caja_abierta_Ab, caja_abierta_Ar, caja_abierta_De, caja_abierta_Iz;
  private PImage caja_cerrada;
  
  //Variable donde se guarda el alto y el ancho
  private float Al;
  private float An;
  
  //Variables globales del HUD
  private float alto_hud;
  private float ancho_hud;
  private float x_hud;
  private float y_hud;
  
  //Variables de los cuadros que se mueven horizontalmente (las imagenes de las cajas)
  private ArrayList<Cuadro> cuadros; //Una lista de objetos
  private float velocidad;
  private float espacioEntreCuadros;
  
  //Margen vertical
  private float margenV;
  
  // Variables para el cuadro en el centro
  private float cuadroCentralAlpha = 0; // Opacidad del cuadro central
  private PImage Imagen_de_salida; //Variable para guardar la imagen de la felcha que salio
  private boolean mostrarCuadroCentral = false; // Controla si se muestra el cuadro central
  
  //Variable por si el juagador aprieta bien o mal
  char tecla_v;
  private int B_o_M;
  private int Opacidad_B_o_M;
  private float puntaje;
  
  // Variable para pausar el nivel
  boolean nivelPausado = false;
  int pausa_fin;
  //Variables para el menu de guarado de puntaje
  char[] iniciales = {'_', '_', '_'}; // Tres espacios en blanco al inicio
  int posicionActual = 0; // Indica qué inicial se está editando
  char[] opciones = {'_', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
  int indiceActual = 0; // Índice en el array de opciones
  int contador=0;
  
  //Puerto para la comunicación
  Serial myPort;
  
  //Metodo que maneja la parte gráfica de los niveles
  int interfazNivel() {
    
    if(!nivelPausado){
      
      if(!player.isPlaying()){
        player.play();// Comienza la reproducción del audio
      }
      
      image(Fondo,0,0); //Fondo del nivel (Imagen);
    
      //Puntaje del jugador en el nivel (mostrar por pantalla)
      fill(200);
      textSize((Al*0.1));
      text(""+int(puntaje),(An/2)-(An/5)/2,Al*0.1);
      
      //felchas
      flechas();
      
      // Dibuja los cuadros (cajas) alrededor del círculo
      
      cuadros();
      
      // Dibujar el cuadro central si está activado
      imagen_central();
      //Manejo de botones y mensajes de error o acierto en el nivel
      manejo_botones();
      //Mensaje de error o acierto
      dibujarMensaje();
      //Musica del nivel
      musica(tecla_v);
      return nivel;
      
    }
    else{
      if(pausa_fin==0){
        nivelPausado=menu_pausa();
      }
      if(pausa_fin==1){
        menu_salida_n();
      }
      if(pausa_fin==2){
        menu_puntaje();
      }
      if(pausa_fin==3){
        
        //Reinicio todas las variables necesarias para cuando se quiera volver a iniciar el nivel
        reiniciarVariables();
        delay(2000);
        return 1;
      }
    }
    return nivel;
    
  }
  
  void flechas(){
    int i;
    // HUD de las flechas presentadas
   
   image(cinta_transportadora,x_hud,y_hud,ancho_hud,alto_hud);
   clip(x_hud, y_hud, ancho_hud, alto_hud);//Recorta el tamaño exacto del HUD
   
   //Recorro desde el final de la lista hasta el inicio por eso -1 al tamaño de la lista
    for ( i = cuadros.size()-1; i >= 0; i--) {
        Cuadro cuadro = cuadros.get(i); //Paso la referencia del objeto del indice i que voy a desplazar y dibujar a cuadros para faciliar su escritura y entender que me estoy refiriendo a un objeto de la lista
        cuadro.mover(velocidad);
        cuadro.dibujar(height*0.1,height*0.12 );

        // Eliminar cuadro si sale de la pantalla
        if (cuadro.x + alto_hud < x_hud) {
          
          Imagen_de_salida=cuadros.get(i).imagen; //Guardo la imagen asociada a la caja con la flecha que va a ser eliminada
          mostrarCuadroCentral = true; //Mostrar cuadro central
          cuadroCentralAlpha = 255;   //Restaurar opacidad
          cuadros.remove(i);

        }
    }

    // Agregar un nuevo cuadro (caja) si hay espacio suficiente al final
    if (cuadros.get(cuadros.size() - 1).x < x_hud + ancho_hud - alto_hud - espacioEntreCuadros) {
        cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    }
    noClip();
  
  }
    //Función (método) para devolver la imagenes de forma aleatoria
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
  
  //Dibujo la imagen de los cuadros del centro 
  void cuadros(){
    int i,j;
    float lado_fle = (Al / 5) * 0.9;
    float margen_fleL = ((An / 5) - lado_fle) / 2;
    float margen_fleV = ((Al / 5) - lado_fle) / 2;
    
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            float x_fle = margen_fleL + (lado_fle + (margen_fleL * 2)) * i;
            float y_fle = margen_fleV + (Al / 5) * j;

            if (i == 2 && j == 1){
              if(tecla_v=='w'){
                image(flecha_arriba_press,x_fle,y_fle,lado_fle,lado_fle);
              }
              else{
                image(flecha_arriba,x_fle,y_fle,lado_fle,lado_fle);
              }
              
            }
            if(i == 1 && j == 2){
                if(tecla_v=='a'){
                image(flecha_izquierda_press,x_fle,y_fle,lado_fle,lado_fle);
              }
              else{
                image(flecha_izquierda,x_fle,y_fle,lado_fle,lado_fle);
              }
              
            }
            if(i == 3 && j == 2){
              
              if(tecla_v=='d'){
                image(flecha_derecha_press,x_fle,y_fle,lado_fle,lado_fle);
              }
              else{
                image(flecha_derecha,x_fle,y_fle,lado_fle,lado_fle);
              }
              
            }
            if(i == 2 && j == 3){
              if(tecla_v=='s'){
                image(flecha_abajo_press,x_fle,y_fle,lado_fle,lado_fle);
              }
              else{
                image(flecha_abajo,x_fle,y_fle,lado_fle,lado_fle);
              }
              
            }
              
            
        }
    }
    
  }
  //Dibujo la imagen central
  void imagen_central(){
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
        puntaje = Math.max(puntaje - 300, 0);
      }  
    }
    noTint();
    imageMode(CORNER);
  
  }
  void manejo_botones(){
    switch(tecla_v) {
    case 'a':
        verificarTecla(caja_abierta_Iz);
        break;
    case 's':
        verificarTecla(caja_abierta_Ab);
        break;
    case 'd':
        verificarTecla(caja_abierta_De);
        break;
    case 'w':
        verificarTecla(caja_abierta_Ar);
        break;
    case 'k':
        break;
        
    }
  }
  
  //Función (método) que verifica que hacer en el caso de cada tecla dependiendiendo de si el usuario se equivocó o no
  void verificarTecla(PImage imagenEsperada) {
    if (imagenEsperada == Imagen_de_salida && mostrarCuadroCentral) {
        mostrarCuadroCentral = false;
        Opacidad_B_o_M = 255;
        tecla_v = ' ';
        B_o_M = 1;
        puntaje += 2.5 * cuadroCentralAlpha;
    } else {
        Opacidad_B_o_M = 255;
        tecla_v = ' ';
        B_o_M = 2;
        puntaje = Math.max(puntaje - 300, 0); //Math.max compara cual resultado es mayor y devuelve el valor más grande
    }
  }
  //Método que dibuja el mensaje los mensaje en caso de ser necesarios
  void dibujarMensaje() {
    tint(255,Opacidad_B_o_M);
    if (B_o_M == 1) { // Correcto
        image(Cuadrado_correcto, 0, 0, width * 0.3, width * 0.3);
    } else if (B_o_M == 2) { // Incorrecto
        image(Cuadrado_error, 0, 0, width * 0.3, width * 0.3);
    }
    Opacidad_B_o_M -= 5;
    if (Opacidad_B_o_M <= 0) B_o_M = 0;
    noTint();
  }
  //Método para el manejo de la musica fuera del nivel
  void musica(char tecla){
   
    if(tecla=='k'){
      player.pause();
      pausa_fin=0;
      tecla_v=' ';
      nivelPausado=true;
      return;
    }
    if(!player.isPlaying()){
      player.pause();
      pausa_fin=1;
      nivelPausado=true;
    }

  }
  boolean menu_pausa(){
    tint(255,200);
    image(Fondo,0,0);
    noTint();
    fill(200);
    float anchoMenu = An / 4;
    float altoMenu = Al / 3;
    float xMenu = (An - anchoMenu) / 2;
    float yMenu = (Al - altoMenu) / 2;
    rect(xMenu, yMenu, anchoMenu, altoMenu, 10); // Con bordes redondeados
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("NIVEL PAUSADO", xMenu + anchoMenu / 2, yMenu + altoMenu /4);
    text("Pulse l para continuar", xMenu + anchoMenu / 2, yMenu + (altoMenu /4)*2);
    text("Pulse k para salir ", xMenu + anchoMenu / 2, yMenu + (altoMenu/4)*3);
    if(tecla_v=='l'){
      return false;
    }
    if(tecla_v=='k'){
      pausa_fin=3;
    }
    return true;
  }
  void menu_salida_n(){
    tint(255,200);
    image(Fondo,0,0);
    noTint();
    fill(200);
    float anchoMenu = An / 4;
    float altoMenu = Al / 3;
    float xMenu = (An - anchoMenu) / 2;
    float yMenu = (Al - altoMenu) / 2;
    rect(xMenu, yMenu, anchoMenu, altoMenu, 10); // Con bordes redondeados

    // Agregar texto o botones dentro del menú
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("NIVEL TERMINADO", xMenu + anchoMenu / 2, yMenu + altoMenu /4);
    text("PUNTAJE: "+int(puntaje), xMenu + anchoMenu / 2, yMenu + (altoMenu /4)*2);
    text("Pulse k para salir ", xMenu + anchoMenu / 2, yMenu + (altoMenu/4)*3);
    
    if(tecla_v=='k'){
      pausa_fin=2;
    }
    
  }
  void menu_puntaje() {
  //Dibujo la imagend el fondo difuminada
  tint(255, 200);
  image(Fondo, 0, 0);
  noTint();
  //Dibujo del menú
  fill(200);
  float anchoMenu = An / 2;
  float altoMenu = Al / 3;
  float xMenu = (An - anchoMenu) / 2;
  float yMenu = (Al - altoMenu) / 2;
  rect(xMenu, yMenu, anchoMenu, altoMenu,10);

  // Título
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("INGRESE SUS INICIALES", xMenu + anchoMenu / 2, yMenu + altoMenu / 4);

  // Mostrar iniciales seleccionadas
  textSize(40);
  for (int i = 0; i < 3; i++) {
    if (i == posicionActual) {
      fill(255, 180, 120); // Color de la inicial seleccionada
    } else {
      fill(0);
    }
    text(iniciales[i], xMenu+anchoMenu/10+(anchoMenu/5*(i+1)) , yMenu + (altoMenu / 2));
  }

  // Controles
  textSize(16);
  fill(0);
  text("W: Subir letra  |  S: Bajar letra  |  A/D: Cambiar posición  |  L: Guardar", xMenu + anchoMenu / 2, yMenu + (altoMenu / 4) * 3);

  // Lógica de navegación
  if (tecla_v == 'w') {
    indiceActual = (indiceActual - 1 + opciones.length) % opciones.length; // Navegación circular hacia atrás
    iniciales[posicionActual] = opciones[indiceActual];
  } else if (tecla_v == 's') {
    indiceActual = (indiceActual + 1) % opciones.length; // Navegación circular hacia adelante
    iniciales[posicionActual] = opciones[indiceActual];
  } else if (tecla_v == 'a') {
    posicionActual = (posicionActual - 1 + 3) % 3; // Moverse entre las iniciales (izquierda)
    indiceActual = getIndice(iniciales[posicionActual]); // Actualizar índice según la inicial actual
  } else if (tecla_v == 'd') {
    posicionActual = (posicionActual + 1) % 3; // Moverse entre las iniciales (derecha)
    indiceActual = getIndice(iniciales[posicionActual]); // Actualizar índice según la inicial actual
  } else if (tecla_v == 'l') {
    if(iniciales[0]!='_' && iniciales[1]!='_' && iniciales[2] != '_'){    
        String nombre = new String(iniciales);
        // Formato "AAA 000000"
        String salida = String.format("%s %06d %s %d", nombre, int(puntaje),"Nivel",nivel-1);
        
        String archivo="puntajes.txt";
        
        // Guardar en un archivo usando saveStrings()
        String[] lineasExistentes = loadStrings("Assets/text/"+archivo);
        String[] nuevaLinea = {salida};
        if (lineasExistentes != null) {
            // Combina líneas existentes con la nueva
            lineasExistentes = (String[]) append(lineasExistentes, salida);
        } else {
            lineasExistentes = nuevaLinea;
        }
        saveStrings("Assets/text/"+archivo, lineasExistentes);
        desbloquear_nivel();
        pausa_fin = 3; // Salir del menú
    }
  }
  tecla_v = '\0'; // Reiniciar tecla
  }
  
  int getIndice(char letra) {
    for (int i = 0; i < opciones.length; i++) {
      if (opciones[i] == letra) {
        return i;
      }
    }
    return 0; // Si no se encuentra, regresar al inicio
  }
  
  //Función para reiniciar variables al finalizar o salir del nivel
  void reiniciarVariables(){
    for(int i=0;i<3;i++){
      iniciales[i]='_';
    }
    tecla_v=' ';
    nivelPausado=false;
    player.rewind();
    cuadros = new ArrayList<Cuadro>();
    cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    mostrarCuadroCentral = false;
    B_o_M=0;
    puntaje=0;
    myPort.write('G');
  }
  void desbloquear_nivel(){
    
    String [] niveles_desbloqueados=loadStrings("Assets/text/niveles_desbloqueados.txt");
    
    int numero_d_niveles=int(niveles_desbloqueados[0].trim());
    
    if(numero_d_niveles<=nivel){
      numero_d_niveles+=1;
      
       PrintWriter output = createWriter("Assets/text/niveles_desbloqueados.txt");
       output.println(numero_d_niveles);
       output.close();
      
    }
    
  }
  
  void cargar_images_nivel(){
    Cuadrado_error=loadImage(directorio+"Cuadrado_error.png");
    Cuadrado_correcto=loadImage(directorio+"Cuadrado_correcto.png");
    
    cinta_transportadora=loadImage(directorio+"Cinta_transportadora.png");
    
    flecha_abajo=loadImage(directorio+"Flecha_abajo.png");
    flecha_arriba=loadImage(directorio+"Flecha_arriba.png");
    flecha_derecha=loadImage(directorio+"Flecha_derecha.png");
    flecha_izquierda=loadImage(directorio+"Flecha_izquierda.png");
    
    flecha_abajo_press=loadImage(directorio+"Flecha_press_abajo.png");
    flecha_arriba_press=loadImage(directorio+"Flecha_press_arriba.png");
    flecha_derecha_press=loadImage(directorio+"Flecha_press_derecha.png");
    flecha_izquierda_press=loadImage(directorio+"Flecha_press_izquierda.png");
    
    caja_abierta_Ab=loadImage(directorio+"Caja_abierta_Ab.png");
    caja_abierta_Ar=loadImage(directorio+"Caja_abierta_Ar.png");
    caja_abierta_De=loadImage(directorio+"Caja_abierta_De.png");
    caja_abierta_Iz=loadImage(directorio+"Caja_abierta_Iz.png");
    
    caja_cerrada=loadImage(directorio+"Caja_cerrada.png");
    }
  
}

//Esta clase es la que utilizo para crearl la lista de objetos
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

    
