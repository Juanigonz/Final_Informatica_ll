//Manejo de audio
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Manejo de comunicación
import processing.serial.*;

/*La clase Niveles es la encargada de gestionar todo lo referido el dibujo del nivel del juego, su manejo y los datos que cada nivel guarda*/
class Niveles{
  
  //Constructor de niveles
  Niveles(float velocidad,float Al, float An,PImage Fondo, String Nivel,PApplet parent,int nivel,Serial myPort){
    
    //Inicialización del puerto
    this.myPort=myPort; //Recibe del programa el objeto Serial creado e inicializado. 
    
    // Inicializar Minim
    minim = new Minim(parent); //Se utiliza la instancia parent para inicializar minim
    
    //Uso this para referirme a las variables globales de la clase
    
    this.Al=Al;//Alto del sketch para el redimencionamiento 
    this.An=An;//Ancho del sketch programa para el 
   
    /*
    Utilizo An y Al para que todas las variables referidas a posiciones y tamaños dependan de un factor del Alto y el Ancho así al variar la escala de
    programa todo conserva un valor proporcional al estar en funcion de las variables Al y An que representan el alto y el ancho respectivamente.
    */
    margenV = An * 0.01; //margen vertical usado también para los cuadros del centro y el hud
  
    //Parametros del rectángulo del hud
    alto_hud = Al * 0.1;
    ancho_hud = An * 0.3;
    x_hud = An - ancho_hud - margenV;
    y_hud = margenV;
    
    //Variable referidas a la música del nivel
    player = minim.loadFile("Assets/music/"+Nivel+"Musica.mp3",1024);
    
    //Variable de control nivel referida a valor int que retorna el programa
    this.nivel=nivel; 
    
    //Imagenes del juego cargar
    directorio = "Assets/img/"+Nivel; //String con el directorio + el nombre de la carpeta con las imagenes referidas al nivel
    this.Fondo=Fondo;//Fondo de pantalla
    
    cargar_images_nivel(); //Función que carga las imagenes referidas a la parte gráfica
    
    //Variables referidas a los cuadros del lateral superior derecho
    cuadros = new ArrayList<Cuadro>(); //Inicialización de la lista de objetos con el constructor ArrayList<>()
    cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria())); //Agregamos un objeto del tipo cuadro a la lista 
    
    espacioEntreCuadros = alto_hud*3; //Variable que gestiona la distancia entre los cuadros
    
     this.velocidad=velocidad*(Al/1280); //Velocidad en pixeles con la que se van desplazando las imagenes del rpograma
    
    /*
    (An/1280) es un factor de rescalado para la velocidad, esto se debe a que el desarrollo del juego fue hecho
    en el tamaño 1280x720 y la velocidad con la que se desplazan las imagenes varía al reescalar la pantalla
    */
    
  }
  //Musica del juego
  Minim minim;
  AudioPlayer player;
  
  //Variable de control que se retorna para el control de escenas en el sketch principal
  int nivel;

  //Imagenes
  private String directorio;
  
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
  private ArrayList<Cuadro> cuadros; //Una lista de objetos creada pero no inicializada
  private float velocidad;
  private float espacioEntreCuadros;
  
  //Margen vertical
  private float margenV;
  
  // Variables para el cuadro en el centro
  private float cuadroCentralAlpha = 0; // Opacidad del cuadro central
  private PImage Imagen_de_salida; //Variable para guardar la imagen de la felcha que salio
  private boolean mostrarCuadroCentral = false; // Controla si se muestra el cuadro central
  
  //Variable por si el juagador aprieta bien o mal
  private int B_o_M;
  private int Opacidad_B_o_M;
  private float puntaje = 0;
  
  //Variable referida al manejo de teclas que pulsa el usuario
  char tecla_v;
  
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "interfazNivel": 
    En este método de la clase Niveles manejo todos los métodos referidos a la parte gráfica en una serie de eventos gestionados con variables
    de control, como lo es la variable "nivelPausado" la cual inicialmente está en false, es decir, la analogía es que si nivelPausado es falso, 
    osea no está pausado, entonces se realizan las acciones dentro del if, sino se gestiona la parte gráfica de los eventos posibles que pausan 
    el juego, como que el jugador quiera salir o que termine el nivel.
    El manejo de los eventos que pausan el nivel están gestionados a través de la variable pausa_fin que es la segunda varibale de control del
    método interfazNivel().
  */
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
      //Manejo de botones
      manejo_botones();
      //Mensaje de error o acierto
      dibujarMensaje();
      //Musica del nivel
      musica(tecla_v);
      return nivel;
      
    }
    else{
      /*
      La variable pausa_fin toma el valor de 0 si el usuario pulsa la letra para volver "k", luego toma el valor de 1
      si el nivel termina, entonces, se le muestra al usaurio un menú que es el de salida y al pulsar "k" en este menu
      la variable toma el valor 2 para mostrar el menu del puntaje con las 3 letras que se solicita que el usuario
      ingrese, al hacer eso y presionar "l" la variable toma el valor 3 y se reinician las variables y se retorna 1 lo que
      en el sketch principal se refleja como pasar de la escena del nivel en cuestión a la escena del menu en el qyue se ven los niveles.
      */
      if(pausa_fin==0){
        //menu_pausa devuelve true mientras se muestre por pantalla el menu de pusar el nivel además dibuja el menu de pausa
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
  /*
  EXPLICACIÓN DEL MÉTODO "flechas":
    Este método es el encargado de dibujaro por pantalla las felchas que van apareciendo.
    Al inicio la lista de objetos "cuadros" se encuentra solo con 1 objeto, este objeto
    contiene la posición x e y de la imagen que con cada iteración del programa va a dibujar
    y mover de posición la imagen, cuando el primer cuadro ha recorrido cierta distancia, 
    determinada por espacioEntreCuadros, se agrega otro objeto Cuadro con posicion de x al extremo
    derecho del HUD entonces ahora con cada iteración del programa el bucle for se repite 2 veces
    una por cada objeto de la lista, esto se repite hasta que un objeto cuadro alcance un valor de
    x delimitado por "x_hud-alto_hud-12", entonces se gurda la imagen de ese cuadro en una variable
    auxiliar y se elimina ese objeto de la lista. La variable auxiliar es la que usaremos luego para
    msotrar por pantalla la felcha que "salió".
  */
  void flechas(){
    int i; 
    
   // HUD de las flechas presentadas
    
   image(cinta_transportadora,x_hud,y_hud,ancho_hud,alto_hud);
   strokeWeight(8);
   stroke(77, 255, 255);
   line(x_hud-alto_hud,y_hud+(alto_hud*0.95),x_hud-(Al*0.01),y_hud+(alto_hud*0.95));
   
   clip(x_hud-alto_hud, y_hud, ancho_hud+alto_hud, alto_hud);//Recortar el tamaño del HUD para que las imagenes de que aparecen en el lateral derecho no se vean
   
    for ( i = cuadros.size()-1; i >= 0; i--) {
        Cuadro cuadro = cuadros.get(i); //Paso la referencia del objeto del indice i que voy a desplazar y dibujar a cuadros para faciliar su escritura y entender que me estoy refiriendo a un objeto de la lista
        cuadro.mover(velocidad);
        cuadro.dibujar(height*0.1,height*0.12 );

        // Eliminar cuadro si sale de la pantalla
        if (cuadro.x< x_hud-alto_hud-12) {
          
          Imagen_de_salida=cuadros.get(i).imagen; //Guardo la imagen asociada a la caja con la flecha que va a ser eliminada
          mostrarCuadroCentral = true; //Mostrar cuadro central
          cuadroCentralAlpha = 255;   //Restaurar opacidad
          cuadros.remove(i);

        }
    }

    // Agregar un nuevo cuadro (caja) si hay espacio suficiente
    /*
    NOTA: la comprobación de si hay espacio o no para agregar un nuevo elemento depende solo del último elemento de la lista, es decir,
    el elememto cuadros.size()-1, por esto utilizo ese valor.
    */
    if (cuadros.get(cuadros.size() - 1).x < x_hud + ancho_hud - espacioEntreCuadros) {
        cuadros.add(new Cuadro(x_hud + ancho_hud, y_hud, obtenerImagenAleatoria()));
    }
    noClip();
    stroke(0);
    strokeWeight(1);
  
  }
  //Función (método) para devolver la imagenes de forma aleatoria
  PImage obtenerImagenAleatoria() {
    float random = random(4.0);
    
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "cuadros":
    Este método dibuja los cuadros o botones del nivel que se encuentran rodeando
    al cuadro que sale por pantalla en el centro de la pantalla, además, dependiendo del valor de tecla_v, que
    es la variable que maneja las téclas presionadas, se dibuja una imagen distinta para devolver por pantalla algún feed
    de que la flecha referida a la tecla pulsada fue pulsada, eso es lo que hacen los if anidados.
  */
  
  //Dibujo la imagen de los cuadros del centro
  void cuadros(){
    int i,j;
    float lado_fle = (Al / 5) * 0.9;
    float margen_fleL = ((An / 5) - lado_fle) / 2;
    float margen_fleV = ((Al / 5) - lado_fle) / 2;
    
    //i hace referencia a las columnas y j hace referencia a las filas
    
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            float x_fle = margen_fleL + (lado_fle + (margen_fleL * 2)) * i;
            float y_fle = margen_fleV + (Al / 5) * j;
            
            //rect(x_fle,y_fle,lado_fle,lado_fle);
            
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "imagen_central":
    Al llegar uno de los cuadros del HUD al extremo izquierdo del HUD antes de ser eliminado ese cuadro se guarda la imagen de este
    en la variable Imagen_de_salida, además la variable mostrarCuadroCentral pasa de ser false a ser true y se cambia el valor de
    cuadroCentralAlpha que servirá para el manejo de la opacidad del cuadro que sale por pantalla, todo esto se raliza en el
    método "flechas", mostrarCuadroCentral es una variable de control que cumple el rol de definir cuando se muestra por pantalla la imagen del
    cuadro en el centro de la interfaz, una vez que mostrarCuadroCentral es true se dibuja en el centro del interfaz el cuadro y se 
    empieza a disminuir su opacidad hasta que sea <= 0 si sucede eso, es porque el usuario no alcanzó a presionar la tecla asociada
    a la imagen que salio por pantalla, entonces cambia la variable mostrarCuadroCentral a false, se coloca la variable Opacidad_B_o_M en 255
    y la variable B_o_M en 2 estás dos variables son, la primera de ellas, la opacidad referida a al carterl de error o acierto de
    y , la segunda de ellas, una variable de control que determina que cartel es el que se muestra por pantalla
  */
  
  //Dibujo la imagen central
  void imagen_central(){
    if (mostrarCuadroCentral) {
      
      float x_disp = An * 0.5;
      float y_disp = Al * 0.5;
      
      imageMode(CENTER);
      tint(255,cuadroCentralAlpha);
      image(Imagen_de_salida,x_disp,y_disp,height*0.12,height*0.1 );
      
      // Reducir la opacidad
      cuadroCentralAlpha -= velocidad;
      
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "manejo_botones":
    Este método solo cumple el rol de que al presionar cierta tecla el usario durante el nivel se manda a verificar
    si la imagen asociada a la tecla es la que se está mostrando por pantalla o no, o si siquiera hay alguna imagen
    por pantalla, es decir solo gesriona el pasaje de imagenes para la comprobación de la tecla a la función
    verificarTecla.
  */
  
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "verificarTecla":
    Este método es llamado en manejo_botones en cada caso de cada tecla lo que hace es verificar si la
    tecla precionada por el usuario coincide con la imagen que salió por pantalla o si siquiera hay una
    imagen a la hora de que el usuario pulse la tecla, para esto compara la imagenEsperada que es la imagen 
    asociada a esa tecla con la imagen que hay en la pantalla, si es que hay una, por eso el "&& mostrarCuadroCentral"
    está ahí, se deben cumplir ambas condiciones, en caso de que el usuario haya acertado mostrarCuadroCentral pasa a ser false
    asi se deja de dibujar ese cuadro, la variable Opacidad_B_o_M toma el valor de 255 para dibujar el cartel de acierto por 
    pantalla se reinicia tecla_v, aunque esto podría haberse hecho en manejo_botones preferí hacerlo acá para evitar repetir
    código, B_o_M toma al valor 1 (1 es el valor de esta variable de control asociado al mensaje de acierto), y se suma una
    cantidad de puntos determinada por cuando se desvanecio el cuadro central multiplicado por 2.5. En caso de que el usuario
    presione mal la tecla o que pulse una tecla cuando nisiquiera hay una imagen por pantalla se pasa por el else, el cual 
    coloca la variable que controla la opacidad del mensaje (Opacidad_B_o_M) en 255, se reinicia tecla_v, y se modifica B_o_M
    al valor 2, se disminuye el puntaje en un valor fijo de 300 puntos pero verificando que no sea menor a cero.
  */
  
  void verificarTecla(PImage imagenEsperada) {
    if (imagenEsperada == Imagen_de_salida && mostrarCuadroCentral) {
        mostrarCuadroCentral = false;
        Opacidad_B_o_M = 255;
        B_o_M = 1;
        puntaje += 2.5 * cuadroCentralAlpha;
    } else {
        Opacidad_B_o_M = 255;
        B_o_M = 2;
        puntaje = Math.max(puntaje - 300, 0); //Math.max compara cual resultado es mayor y devuelve el valor más grande
    }
    tecla_v = ' ';
  }
  
  /*
  EXPLICACIÓN DEL MÉTODO "dibujarMensaje":
    Este método lo que hace es que dependiendo del valor de la variable de control B_o_M dibuja un mensaje u otro, además disminuye
    la opacidad del mensaje para que ese desaparezca de forma tenue, una ves que la variable Opacidad_B_o_M sea <= 0 se reinicia la
    variable B_o_M a 0 para evitar que se siga viendo la imagen.
  */
  
  void dibujarMensaje() {
    tint(255,Opacidad_B_o_M);
    if (B_o_M == 1) { // Correcto
        image(Cuadrado_correcto, 0, 0, width * 0.3, width * 0.3);
    } else if (B_o_M == 2) { // Incorrecto
        image(Cuadrado_error, 0, 0, width * 0.3, width * 0.3);
    }
    Opacidad_B_o_M -= velocidad*1.2;
    if (Opacidad_B_o_M <= 0) B_o_M = 0;
    noTint();
  }
  
  /*
  EXPLICACIÓN DEL MÉTODO "musica":
    Este método se encarga de pausar la música del juego, cuando el usuario pulsa k durante la ejecución
    del nivel se pausa la musica con player.pause(), se coloca pausa_fin en 0, además nivelPausado se pone en true, esto
    produce que no pasemos por el if de interfazNivel sino que entremos en el else y en su primer if, en el de la función
    menu_pausa, el otro if sirve para que si la música del nivel finaliza nivelPausado también se coloque en true, no
    pasemos tampoco por el primer if del método interfazNivle y que en el else pasemos por el 2do if y que se pause la
    música.
  */
  
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "menu_pausa":
    este método dibuja el menu de pausa y gestiona lo que hace este menu dependiendo de la tecla presionada
    por el usuario, si el usuario pula l retorna false lo que se devuelve y cambia a la variable nivelPausado
    y reanuda el juego, en cambio si pulsa k se modifica pausa_fin al valor 3 y como nivelPuasado sigue siendo
    true se entra en el else de interfazNivel y se entra en el ultimo if sacando al usuario del nivel en cuestión.
  */
  
  boolean menu_pausa(){
    fill(60, 1);
    rect(0, 0, width, height);
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "menu_salida_n":
    cuando la música termina el valor de nivelPausado pasa a true y pausa_fin pasa a 1 entonces se entra en el else de interfazNivel
    y se entra en el 2do if de dicho else, entonces se llama a menu_salida_n que dibuja el mensaje de que el nivel terminó, se muestra
    el puntaje al usuario y se le pide que pulse k para salir, al pulsar k se cambia pausa_fin a 2 para pasar al siguiente if.
  */
  
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
  
  /*
  EXPLICACIÓN DEL MÉTODO "menu_puntaje":
    Luego de que teminó la música y de pasar por el else de interfazNivel y que se pasara por el 2do if del else y que el suario pulsara k
    se pasa por el 3er if el cual maneja el guardado del puntaje del usuario con el método menu_puntaje, este método dibuja por patnalla 
    el menú en el que se le solicita al usuario que ingrese un conjunto de 3 letras referidas a su nombre y luego pulse l para guardar el 
    puntaje. La explicación detallada de como funciona este método está redactada en forma de comentarios en el método, ya que es algo extensa.
  */
  
  void menu_puntaje() {
  //Dibujo la imagen el fondo difuminada
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

  // Escribo el título
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("INGRESE SUS INICIALES", xMenu + anchoMenu / 2, yMenu + altoMenu / 4);
  
  // Mostrar iniciales seleccionadas
  textSize(40);
  for (int i = 0; i < 3; i++) {
    if (i == posicionActual) {
      fill(44, 117, 255); // Color de la inicial seleccionada
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
    
    /*La función getIndice sirve para evitar que al dejar una letra en uno de los espacios de selección y cambiar a otra para
    seleccionar otra letra esta mantenga el indice de la anterior, entonces la función get indice devuelve un valor asociado
    a la letra que en la que está posicionado, entonces esto permite que cada letra se mueva de forma independiente del indice
    de la anterior*/
    
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
    posicionActual=0;
  }
  /*
  EXPLICACIÓN DEL MÉTODO "desbloquear_nivel":
    Este método lo que hace es obtener un número de un archivo .txt y luego
    lo compara para determinar si le debe o no suma 1 para desbloquear el nivel.
  */
  void desbloquear_nivel(){
    
    String [] niveles_desbloqueados=loadStrings("Assets/text/niveles_desbloqueados.txt");
    
    int numero_d_niveles=int(niveles_desbloqueados[0].trim());
    
    if(numero_d_niveles<=nivel){
      numero_d_niveles=nivel+1;
      
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

    
